# frozen_string_literal: true

class FetchLastCommitJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    repository_check = Repository::Check.find(check_id)
    repository_name = repository_check.repository.github

    client = Octokit::Client.new(access_token: current_user&.token, auto_paginate: true)

    result = client.commits(full_link(repository_name)).first
    last_commit = result[:sha][..6]

    repository_check.update!(commit_id: last_commit)
  end

  private

  def full_link(url)
    "https://github.com/#{url}"
  end
end
