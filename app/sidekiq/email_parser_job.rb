# frozen_string_literal: true

class EmailParserJob
  require 'mail'
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(message_id)
    @message = Message.find(message_id)

    @email_path = @message.email.path
    @email_content = File.read(@email_path)
    @eml = Mail.read_from_string(@email_content)
    @body_encoded = @eml.text_part.body.decoded.force_encoding('UTF-8')
    update_attributes = @message.update!(subject: @eml.subject, body: @body_encoded, from: @eml.from,
                                         to: @eml.to)
    parse_email
    @message.update!(processed: true) if update_attributes
  end

  def parse_email
    @lead_data = @message.build_lead_data
    @lead_data.name = @body_encoded.match(/(?<=Nome: ).*/).to_s
    @lead_data.phone = @body_encoded.match(/(?<=Telefone: ).*/).to_s
    @lead_data.client_message = @body_encoded.match(/(?<=Mensagem: ).*/).to_s
    @lead_data.vehicle = @body_encoded.match(/(?<=Veículo de interesse: ).*/).to_s
    @lead_data.vehicle_year = @body_encoded.match(/(?<=Ano: ).*/).to_s
    @lead_data.vehicle_link = @body_encoded.match(%r{\b(?:https?|ftp)://[\w-]+(?:\.[\w-]+)+\S*}).to_s
    @lead_data.vehicle_price = @body_encoded.match(/(?<=Preço: ).*/).to_s
    @lead_data.save!
  end
end
