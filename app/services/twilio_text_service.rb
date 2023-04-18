class TwilioTextService
  require 'twilio-ruby'

  def initialize
    @twilio_client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_text
    @twilio_client.messages.create(
      to: laney_phone,
      from: phone_number,
      body: 'TurtleTime')
  end

  private

    def laney_phone
      18027341583
      # 15124767987
    end

    def account_sid
      Rails.application.credentials.twilio[:account_sid]
    end
    def auth_token
      Rails.application.credentials.twilio[:auth_token]
    end
    def phone_number
      Rails.application.credentials.twilio[:phone_number]
    end
end