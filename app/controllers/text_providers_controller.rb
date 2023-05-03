class TextProvidersController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering
  before_action :set_text_providers

  def index
    render layout: 'application'
  end

  def new
    @text_provider = TextProvider.new
    render layout: 'application'
  end

  def create
    @text_provider = TextProvider.new(text_provider_params)

    if @text_provider.save
      render action: :index, layout: 'application'
    else
      @text_provider.errors.add(:base, 'There was a problem, please try again')
      render action: :show, layout: 'application'
    end
  end

  def edit
    @text_provider = TextProvider.find_by(id: params[:id])
    render layout: 'application'
  end

  def update_provider
    @text_provider = TextProvider.find_by(id: params[:text_provider_id])
     if @text_provider.update(text_provider_params)
      render action: :index, layout: 'application'
    else
      @text_provider.errors.add(:base, 'There was a problem, please try again')
      render action: :show, layout: 'application'
    end
  end

  def delete_provider
    @text_provider = TextProvider.find_by(id: params[:text_provider_id])
    @text_provider.destroy
    render action: :index, layout: 'application'
  end

  def reset_counts
    ResetTextProviderCountsJob.perform_now
    render action: :index, layout: 'application'
  end

  private

    def text_provider_params
      params.require(:text_provider).permit(:name, :allocation, :active, :count, :url)
    end


    def set_text_providers
      @text_providers = TextProvider.all
    end

    def text_message_params
      params.require(:text_message).permit(:to_number, :message, :message_id)
    end
end
