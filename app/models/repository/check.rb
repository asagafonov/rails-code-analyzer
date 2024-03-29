# frozen_string_literal: true

require 'aasm'

class Repository::Check < ApplicationRecord
  include AASM
  belongs_to :repository
  has_many :linter_errors, dependent: :destroy

  aasm whiny_transition: false do
    state :idle, initial: true
    state :in_progress
    state :finished
    state :failed

    event :start_checking do
      transitions from: :idle, to: :in_progress
    end

    event :mark_as_finished do
      transitions from: :in_progress, to: :finished
    end

    event :mark_as_failed do
      transitions to: :failed
    end
  end

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end
