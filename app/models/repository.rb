# frozen_string_literal: true

require 'aasm'

class Repository < ApplicationRecord
  include AASM
  extend Enumerize

  belongs_to :user

  aasm column: :state, whiny_transition: false do
    state :default, initial: true
    state :fetching
    state :fetched
    state :failed

    event :start_fetching do
      transitions to: :fetching
    end

    event :succeed do
      transitions from: :fetching, to: :fetched
    end

    event :fail do
      transitions from: :fetching, to: :failed
    end
  end

  enumerize :language, in: [:javascript], scope: true
  validates :github, presence: true
end
