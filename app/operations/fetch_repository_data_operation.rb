# frozen_string_literal: true

class FetchRepositoryDataOperation
  def self.run(repository_id)
    UpdateRepositoryJob.perform_now(repository_id)
  end
end

class FetchRepositoryDataOperationStub
  def self.run(repository_id)
    repository = Repository.find(repository_id)

    repository.update!(
      name: Faker::Lorem.sentence(word_count: 2),
      language: 'JavaScript'
    )

    repository.succeed!
  end
end
