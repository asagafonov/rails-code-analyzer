# frozen_string_literal: true

class UpdateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    repository.start_fetching!

    api = github_api(repository.user)

    data = api.fetch_repository_data(repository)
    api.create_hook(repository[:full_name])

    repository.update!(
      name: data[:name],
      language: data[:language].downcase.to_sym
    )

    repository.succeed!
  rescue StandardError
    repository.fail!
  end

  private

  def github_api(user)
    ApplicationContainer[:octokit].new(user)
  end
end
