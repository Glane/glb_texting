class TextProvider < ApplicationRecord
  include TextProviderStateMachine
  include AASM

  scope :active, -> { where(active: true) }
  scope :active_and_online, -> { where(active: true, state: 'online') }
end