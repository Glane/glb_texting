require 'uri'
require 'net/http'
require 'json'

class SendTextMessage
  def call(text_message, provider)
    # binding .irb
    @text_message = text_message
    url = URI(provider.url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = @text_message.prepare_request(url)

    response = http.request(request)
    response = JSON.parse(response.read_body)
    process_response(response, provider)
  end

  private

    def process_response(response, provider)
      update_count(provider)
      # binding.pry
      if response['message_id']
        @text_message.pending!
        @text_message.update!(message_id: response['message_id'])
      else
        provider.down!
        send_to_next_provider
      end
    end

    def update_count(provider)
      provider.update!(count: (provider.count + 1))
    end

    def send_to_next_provider
      providers = TextProvider.active_and_online
      # binding.pry
      if providers.empty?
        @text_message.fail!
      else
        @text_message.retry!
        call(@text_message, providers.first)
      end
    end
end

