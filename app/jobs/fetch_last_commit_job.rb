# frozen_string_literal: true

class FetchLastCommitJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find_by(id: check_id)
    return unless check

    user = check.repository.user
    github_id = check.repository.github_id

    commit_data = github_api(user).fetch_last_commit_data(github_id)

    check.update(
      last_commit_sha: commit_data[:last_commit_sha],
      last_commit_url: commit_data[:last_commit_url]
    )
  end

  private

  def github_api(user)
    ApplicationContainer[:octokit].new(user)
  end
end
