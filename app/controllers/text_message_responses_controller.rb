class TextMessageResponsesController < ApplicationController
  before_action :set_message_and_status

  def create
    text_message = TextMessage.find_by(message_id: @message_id)
    text_message.update!(state: @status)
  end

  private

    def text_message_response_params
      params.require(:text_message_response).permit(:status, :message_id)
    end

    def set_message_and_status
      @message_id = text_message_response_params['message_id']
      @status = find_status_name
    end

    def find_status_name
      state = text_message_response_params['status']
      state == 'invalid' ? 'number_invalid' : state
    end
end
