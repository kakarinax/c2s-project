class EmailParserWorker
  require 'mail'
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    @message = Message.find(id)
    @eml = Mail.read(@message.email.path)
    @message.update(
      subject: @eml.subject,
      from: @eml.from,
      to: @eml.to,
      body: @eml.body
    )

    @message.save

    @message
  end
end
