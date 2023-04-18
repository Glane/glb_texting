class TextMessagesController < ApplicationController
  def index
    render json: TextMessage.all
  end

  def create
    text_message = TextMessage.new(text_message_params)

    if text_message.save
      TextLoadBalancer.new.call(text_message)
    else
      render json: text_message.errors
    end
  end

  # def update
  #   binding.irb
  # end

  private

    def text_message_params
      params.require(:text_message).permit(:to_number, :message, :message_id)
    end
end
