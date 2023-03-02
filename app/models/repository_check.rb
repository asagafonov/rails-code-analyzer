# frozen_string_literal: true

require 'aasm'

class RepositoryCheck < ApplicationRecord
  include AASM
  belongs_to :repository

  aasm column: :state, whiny_transition: false do
    state :idle, initial: true
    state :in_progress
    state :passed
    state :failed

    event :start_checking do
      transitions from: :idle, to: :in_progress
    end

    event :mark_as_passed do
      transitions from: :in_progress, to: :passed
    end

    event :mark_as_failed do
      transitions from: :in_progress, to: :failed
    end
  end

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end
