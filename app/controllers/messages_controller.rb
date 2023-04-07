class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      EmailParserWorker.perform_async(@message.id)
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:email)
  end
end
