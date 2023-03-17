# frozen_string_literal: true

class OctokitClientStub
  def initialize(*); end

  def fetch_repositories
    [
      Repository.new(full_name:),
      Repository.new(full_name:),
      Repository.new(full_name:),
      Repository.new(full_name:),
      Repository.new(full_name:),
      Repository.new(full_name:)
    ]
  end

  def fetch_last_commit_data(_github_id)
    {
      last_commit_sha: random_sha[..6],
      last_commit_url: "https://github.com/example/Example/commit/#{random_sha}"
    }
  end

  def fetch_repository_data(_github_id)
    {
      name: repo_name,
      language: %w[javascript ruby].sample,
      full_name:,
      default_branch: 'main',
      clone_url: "https://github.com/#{full_name}.git",
      created_at: '2021-08-15T00:14:22Z',
      updated_at: '2021-08-15T00:14:22Z'
    }
  end

  def create_hook(_id)
    ''
  end

  private

  def random_name
    Faker::Lorem.characters(number: 6, min_alpha: 6)
  end

  def random_sha
    Faker::Lorem.characters(number: 12, min_alpha: 6)
  end

  def user_name
    random_name
  end

  def repo_name
    random_name.capitalize
  end

  def full_name
    "#{user_name}/#{repo_name}"
  end
end
