class ResetTextProviderCountsJob < ApplicationJob
  queue_as :default

  def perform
    TextProvider.all.each { |provider| provider.update(count: 0) }
  end
end
