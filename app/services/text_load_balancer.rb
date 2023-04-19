class TextLoadBalancer

  def call(text_message)
    reset_providers
    provider = TextProvider.find_by(id: select_provider_id)
    SendTextMessage.new.call(text_message, provider)
  end

  def select_provider_id
    total_text_count = TextProvider.active.sum(:count)
    TextProvider.active.each_with_object([]) do |provider, array|
      lag = (provider.allocation * total_text_count).round - provider.count
      array << [provider.id, lag.round]
    end.max_by { |array| array.last }.first
  end

  def reset_providers
    TextProvider.all.each { |provider| provider.up! }
  end
end