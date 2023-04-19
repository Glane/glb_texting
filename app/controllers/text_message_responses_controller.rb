class TextMessageResponsesController < ApplicationController
  before_action :set_message_and_status, only: :create

  def create
    binding.irb
    text_message = TextMessage.find_by(message_id: @message_id)
    text_message.update!(state: @status)
  end

  private

    def text_message_response_params
      params.require(:text_message_response).permit(:status, :message_id)
    end

    def set_message_and_status
      @message_id = text_message_response_params['message_id']
      @status = text_message_response_params['status']
    end
end
