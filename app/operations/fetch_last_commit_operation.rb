# frozen_string_literal: true

class FetchLastCommitOperation
  def self.run(check_id)
    FetchLastCommitJob.perform_later(check_id)
  end
end
