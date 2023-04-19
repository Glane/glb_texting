class TextMessage < ApplicationRecord
  include TextMessageStateMachine
  include AASM

  validates :to_number, presence: true
  validates :message, presence: true

  CALLBACK_URL = "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"
end

# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee message", "callback_url": "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"}' https://27c4-104-12-203-65.ngrok-free.app/text_messages

# curl -H "Content-Type: application/json" -d '{"message_id": "802", "status": "delivered"}' http://localhost:3000/text_message_responses -v