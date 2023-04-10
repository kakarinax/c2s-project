class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      EmailParserJob.perform_in(1.second, @message.id)
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  def show
    @message = Message.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @message.to_json }
    end
  end

  private

  def message_params
    params.require(:message).permit(:email)
  end
end
