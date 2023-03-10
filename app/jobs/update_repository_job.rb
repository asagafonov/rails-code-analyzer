# frozen_string_literal: true

class UpdateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    repository.start_fetching!

    data = OctokitClient.new(repository.user).fetch_repository_data(repository)

    repository.update!(
      name: data[:name],
      language: data[:language].downcase.to_sym
    )

    repository.succeed!
  rescue StandardError
    repository.fail!
  end
end
