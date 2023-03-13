# frozen_string_literal: true

require 'octokit'

class OctokitClient
  def initialize(user)
    @client = Octokit::Client.new(
      access_token: user.token,
      auto_paginate: true
    )
  end

  def fetch_repositories
    existing_repos = Repository.all.map(&:full_name)

    @client.repos.filter do |repo|
      Repository.language.values.collect(&:text).include?(repo[:language]) && !existing_repos.include?(repo[:full_name])
    end
  end

  def fetch_last_commit_data(check)
    repo_name = check.repository.github_id
    commit_data = @client.commits(repo_name).first

    {
      last_commit_sha: commit_data[:sha][..6],
      last_commit_url: commit_data[:html_url]
    }
  end

  def fetch_repository_data(repository)
    link = full_link(repository.github_id)

    github_repo = Octokit::Repository.from_url(link)

    @client.repository(github_repo)
  end

  def create_hook(github_id)
    hook_url = Rails.application.routes.url_helpers.api_checks_url

    @client.hooks(github_id).each do |hook|
      @client.remove_hook(github_id, hook[:id]) if hook[:config][:url] == hook_url
    end

    @client.create_hook(
      github_id,
      'web',
      { url: hook_url, content_type: 'json' },
      { events: ['push'], active: true }
    )
  end

  private

  def full_link(url)
    "https://github.com/#{url}"
  end
end
