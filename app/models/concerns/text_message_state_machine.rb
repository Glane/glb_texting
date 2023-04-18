module TextMessageStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm do
      state :requested, initial: true
      state :pending # request received, waiting for callback response
      state :retrying # provider failed, trying other providers
      state :failed # failed response or no providers online
      state :invalid # invalid response received
      state :delivered # delivered response received

      event :pending do
        transitions from: %i[requested retrying], to: :pending
      end

      event :retry do
        transitions from: %i[requested], to: :retrying
      end

      event :fail do
        transitions from: %i[pending], to: :failed
      end

      event :deliver do
        transitions from: %i[pending], to: :delivered
      end

      event :invalid do
        transitions from: %i[pending], to: :invalid
      end
    end
  end
end
