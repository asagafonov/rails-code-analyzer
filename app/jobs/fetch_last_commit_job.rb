# frozen_string_literal: true

class FetchLastCommitJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find(check_id)
    return unless check

    commit_data = github_api(check.repository.user).fetch_last_commit_data(check)

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
