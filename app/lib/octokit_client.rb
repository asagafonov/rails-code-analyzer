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
    existing_repos = Repository.all.map(&:github)

    @client.repos.filter do |repo|
      Repository.language.values.collect(&:text).include?(repo[:language]) && !existing_repos.include?(repo[:full_name])
    end
  end

  def fetch_commit_id(check)
    repo_name = check.repository.github
    full_commit_id = @client.commits(repo_name).first
    full_commit_id[:sha][..6]
  end

  def fetch_repository_data(repository)
    link = full_link(repository.github)

    github_repo = Octokit::Repository.from_url(link)

    @client.repository(github_repo)
  end

  def create_hook(id)
    hook_url = Rails.application.routes.url_helpers.api_checks_url

    @client.hooks(id).each do |hook|
      @client.remove_hook(id, hook[:id]) if hook[:config][:url] == hook_url
    end

    @client.create_hook(
      id,
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
