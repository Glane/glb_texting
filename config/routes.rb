Rails.application.routes.draw do
  resources :text_messages, only: [ :create, :update ]
  resources :text_message_responses, only: [ :create ]
end
