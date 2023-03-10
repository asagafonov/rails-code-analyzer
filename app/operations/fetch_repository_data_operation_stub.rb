# frozen_string_literal: true

class FetchRepositoryDataOperationStub
  def self.run(repository_id)
    repository = Repository.find(repository_id)

    repository.start_fetching!

    repository.update!(
      name: "user/reponame#{Faker::Number.unique.number(digits: 2)}",
      language: %w[javascript ruby].sample
    )

    repository.succeed!
  end
end
