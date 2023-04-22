class TextMessage < ApplicationRecord
  include TextMessageStateMachine
  include AASM

  validates :to_number, presence: true
  validates :message, presence: true
  validate  :not_established_invalid

  CALLBACK_URL = "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"

  private

    def not_established_invalid
      text_message = TextMessage.find_by(to_number: to_number)
      if text_message.present? && text_message.number_invalid?
        errors.add(:to_number, 'is invalid.')
      end
    end
end

# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee message", "callback_url": "https://27c4-104-12-203-65.ngrok-free.app/text_message_responses"}' https://27c4-104-12-203-65.ngrok-free.app/text_messages
# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee hihihihimessage", "callback_url": "http://localhost:3000/text_message_responces"}' http://localhost:3000/text_messages -v

# curl -H "Content-Type: application/json" -d '{"message_id": "802", "status": "delivered"}' http://localhost:3000/text_messages -v
# curl -H "Content-Type: application/json" -d '{"message_id": "802", "status": "delivered"}' http://localhost:3000/text_message_responces -v