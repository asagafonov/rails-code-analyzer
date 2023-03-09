# frozen_string_literal: true

class Repository::Check::LinterError < ApplicationRecord
  belongs_to :check
end
