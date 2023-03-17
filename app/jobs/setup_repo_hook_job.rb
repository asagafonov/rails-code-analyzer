# frozen_string_literal: true

class SetupRepoHookJob < ApplicationJob
  queue_as :default

  def perform(repo)
    github_api(repo.user).create_hook(repo.github_id)
  rescue StandardError => e
    logger.error "Error creating repository hook: #{e}"
  end

  private

  def github_api(user)
    ApplicationContainer[:octokit].new(user)
  end
end
