Rails.application.routes.draw do
  root 'text_messages#index'

  resources :text_messages, only: [ :index, :new, :create ]
  resources :text_message_responses, only: [ :create ]
  resources :text_providers, only: [ :index, :new, :create, :edit, :update ] do
    post :update_provider
    get  :delete_provider
    collection do
      get :reset_counts
    end
  end
end
