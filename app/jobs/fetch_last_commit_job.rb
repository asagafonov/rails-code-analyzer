# frozen_string_literal: true

class FetchLastCommitJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    check = Repository::Check.find(check_id)

    commit_id = github_api(check.repository.user).fetch_commit_id(check)

    check.update!(commit_id:)
  end

  private

  def github_api(user)
    ApplicationContainer[:octokit].new(user)
  end
end
