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

  private

  def full_link(url)
    "https://github.com/#{url}"
  end
end
