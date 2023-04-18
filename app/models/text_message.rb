class TextMessage < ApplicationRecord
  include TextMessageStateMachine
  include AASM

  validates :to_number, presence: true
  validates :message, presence: true

  CALLBACK_URL = "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"
end

# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee message", "callback_url": "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"}' https://27c4-104-12-203-65.ngrok-free.app/text_messages

# curl -X POST -H "Content-Type: application/json" -d '{"message": "This is my wonderful"}' http://localhost:3000/text_messages -v