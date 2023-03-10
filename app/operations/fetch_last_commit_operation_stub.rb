# frozen_string_literal: true

class FetchLastCommitOperationStub
  def self.run(check_id)
    repository_check = Repository::Check.find(check_id)

    repository_check.update!(
      commit_id: Faker::Lorem.characters(number: 6, min_alpha: 4)
    )
  end
end
