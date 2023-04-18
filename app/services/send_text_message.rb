class SendTextMessage
  require 'uri'
  require 'net/http'
  include TextMessageStateMachine
  include TextProviderStateMachine

  def call(text_message, provider)
    @text_message = text_message

    url = URI(provider.url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    set_request(url)

    response = http.request(@request)
    response = JSON.parse(response.read_body)
    process_response(response, provider)
  end

  def set_request(url)
    @request = Net::HTTP::Post.new(url)
    @request["Content-Type"] = "application/json"
    @request.body = JSON.dump({
      "to_number" => @text_message.to_number,
      "message" => @text_message.message,
      "callback_url" => TextMessage::CALLBACK_URL
    })
  end

  def process_response(response, provider)
    update_count(provider)
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
    if providers.empty?
      @text_message.fail!
    else
      @text_message.retry!
      call(@text_message, providers.first)
    end
  end
end

