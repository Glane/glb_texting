class TextMessagesController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering
  def index
    @text_message = TextMessage.all
    render 'index'
  end

  def create
    return if number_invalid?
    text_message = TextMessage.new(text_message_params)

    if text_message.save
      TextLoadBalancer.new.call(text_message)
    else
      render json: text_message.errors
    end
  end

  private

    def text_message_params
      params.require(:text_message).permit(:to_number, :message, :message_id)
    end

    def number_invalid?
      text_message = TextMessage.find_by(to_number: 8027341583)
      text_message.present? && text_message.invalid?
    end
end
