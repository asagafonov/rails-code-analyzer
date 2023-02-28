# frozen_string_literal: true

require 'octokit'

class UpdateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    repository.start_fetching!

    fetch_and_update(repository)

    repository.succeed!
  rescue StandardError
    repository.fail!
  end

  private

  def fetch_and_update(repository)
    client = Octokit::Client.new
    link = full_link(repository.github)

    github_repo = Octokit::Repository.from_url(link)
    data = client.repository(github_repo)

    repository.update!(
      name: data[:name],
      language: data[:language].downcase.to_sym
    )
  end

  def full_link(url)
    "https://github.com/#{url}"
  end
end
