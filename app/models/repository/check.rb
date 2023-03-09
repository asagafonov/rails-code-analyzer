# frozen_string_literal: true

require 'aasm'

class Repository::Check < ApplicationRecord
  include AASM
  belongs_to :repository

  aasm column: :state, whiny_transition: false do
    state :idle, initial: true
    state :in_progress
    state :passed
    state :failed
    state :raised_error

    event :start_checking do
      transitions from: :idle, to: :in_progress
    end

    event :mark_as_passed do
      transitions from: :in_progress, to: :passed
    end

    event :mark_as_failed do
      transitions from: :in_progress, to: :failed
    end

    event :raise_error do
      transitions from: :in_progress, to: :raised_error
    end
  end

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end
