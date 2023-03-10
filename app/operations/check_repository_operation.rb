# frozen_string_literal: true

class CheckRepositoryOperation
  def self.run(check_id)
    CheckRepositoryCodeJob.perform_later(check_id)
  end
end
