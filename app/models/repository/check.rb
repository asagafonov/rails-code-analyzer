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

    event :start_checking do
      transitions from: :idle, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :finished
    end
  end

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
end
