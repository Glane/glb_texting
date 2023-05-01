require 'uri'
require 'net/http'
require 'json'

class TextMessage < ApplicationRecord
  include TextMessageStateMachine
  include AASM

  validates :to_number, presence: true
  validates :message, presence: true
  validates :callback_url, format: URI::regexp(%w[http https])

  scope :for_number_with_invalid_status, lambda { |to_number|
    where(to_number: to_number, state: 'number_invalid')
  }

  CALLBACK_URL = "https://a23f-104-12-203-65.ngrok-free.app/text_message_responses"

  def prepare_request(url)
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "to_number" => to_number,
      "message" => message,
      "callback_url" => callback_url || CALLBACK_URL
    })
    request
  end

  # def set_request(url)

  # end

end

# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee message", "callback_url": "https://a23f-104-12-203-65.ngrok-free.app/text_message_responses"}' https://a23f-104-12-203-65.ngrok-free.app/text_messages
# curl -H "Content-Type: application/json" -d '{"to_number": "8027341583", "message": "This is my Frisbee hihihihimessage", "callback_url": "http://localhost:3000/text_message_responces"}' http://localhost:3000/text_messages -v
# curl -H "Content-Type: application/json" -d '{"to_number": "3027341583", "message": "This is my Frisbee hihihihimessage", "callback_url": "http://localhost:3000/text_message_responces"}' http://localhost:3000/text_messages -v

# curl -H "Content-Type: application/json" -d '{"to_number": "2234567890", "message": "popcorn rules", "callback_url": "http://localhost:3000/text_message_responces"}' http://localhost:3000/text_messages -v
# curl -H "Content-Type: application/json" -d '{"message_id": "1234567890", "status": "delivered"}' http://localhost:3000/text_messages -v
# curl -H "Content-Type: application/json" -d '{"message_id": "3d464c11-3b90-4510-8ade-6adc5532b1fd", "status": "invalid"}' http://localhost:3000/text_message_responces -v