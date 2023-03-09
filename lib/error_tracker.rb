# frozen_string_literal: true

class ErrorTracker
  class << self
    def write(check, errors)
      errors.each do |error|
        pp error.message
      end
    end
  end
end