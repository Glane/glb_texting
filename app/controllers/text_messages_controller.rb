class TextMessagesController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering

  def index
    @text_message = TextMessage.all
    render 'index'
  end

  def create
    text_message = TextMessage.new(text_message_params)

    if text_message.save
      send_message(text_message)
    else
      render json: text_message.errors
    end
  end

  private

    def text_message_params
      params.require(:text_message).permit(:to_number, :message, :message_id)
    end

    def number_invalid?
      text_message = TextMessage.find_by(to_number: text_message_params[:to_number])
      text_message.present? && text_message.invalid?
    end

    def send_message(text_message)
      provider = TextProvider.load_selected_provider
      SendTextMessage.new.call(text_message, provider)
    end
end
