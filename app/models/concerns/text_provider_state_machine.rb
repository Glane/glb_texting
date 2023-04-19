module TextProviderStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
      state :online, initial: true
      state :offline # provider offline

      event :up do
        transitions from: %i[online offline], to: :online
      end

      event :down do
        transitions from: %i[online offline], to: :offline
      end
    end
  end
end
