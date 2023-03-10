# frozen_string_literal: true

class FetchRepositoryDataOperation
  def self.run(repository_id)
    UpdateRepositoryJob.perform_later(repository_id)
  end
end
