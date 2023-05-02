                                class TextMessagesController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering
  before_action :set_text_messages

  def index
    render layout: 'application'
  end

  def new
    @text_message = TextMessage.new
    render layout: 'application'
  end

  def create
    @text_message = TextMessage.new(text_message_params)
    if request.headers['Content-Type'] == 'application/json'
      if @text_message.save
        send_message
        render json: @text_message
      else
        render json: text_message.errors
      end
    else
      if @text_message.save
        send_message
        render action: :show, layout: 'application'
      else
        render action: :show, layout: 'application'
      end
    end
  end

  def show
    @text_message = TextMessage.find_by(id: params[:id])
  end

  private

    def set_text_messages
      @text_messages = TextMessage.order(created_at: :desc)
                                  .paginate(page: params[:page], per_page: 12)
    end

    def text_message_params
      params.require(:text_message).permit(:to_number, :message, :message_id, :callback_url)
    end

    def number_has_ever_been_invalid?
      invalid_flag = TextMessage.for_number_with_invalid_status(@text_message.to_number).any?
      @text_message.number_invalid! if invalid_flag
      invalid_flag
    end

    def send_message
      return if number_has_ever_been_invalid?

      TextProvider.reset_providers
      provider = TextProvider.load_selected_provider
      SendTextMessage.new.call(@text_message, provider)
    end
end
