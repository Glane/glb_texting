require 'uri'
require 'net/http'
require 'json'

class TextMessage < ApplicationRecord
  include TextMessageStateMachine
  include AASM

  PHONE_REGEX = /\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\z/
  CALLBACK_URL = "https://a23f-104-12-203-65.ngrok-free.app/text_message_responses"

  validates :to_number, presence: true, format: { with: PHONE_REGEX }
  validates :message, presence: true
  validates :callback_url, format: URI::regexp(%w[http https])

  scope :for_number_with_invalid_status, lambda { |to_number|
    where(to_number: to_number, state: 'number_invalid')
  }


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
end
