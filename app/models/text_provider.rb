class TextProvider < ApplicationRecord
  include TextProviderStateMachine
  include AASM
    validates :name, presence: true
    validates :url, presence: true

    scope :active, -> { where(active: true) }
    scope :active_and_online, -> { where(active: true, state: 'online') }

    def self.load_selected_provider
      total_count = TextProvider.active.sum(:count)
      provider_id = load_calculation(total_count).max_by { |array| array.last }.first
      TextProvider.find_by(id: provider_id)
    end

    def self.reset_providers
      active.each { |provider| provider.up! }
    end

    private

    def self.load_calculation(total_count)
      TextProvider.active.each_with_object([]) do |provider, array|
        dif = (provider.allocation * total_count).round - provider.count
        array << [provider.id, dif]
      end
    end
end
