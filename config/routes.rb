Rails.application.routes.draw do
  resources :text_messages, only: [ :index, :create ]
  resources :text_message_responses, only: [ :create ]
end
