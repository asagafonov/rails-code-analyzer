# frozen_string_literal: true

client_id = ENV['GITHUB_CLIENT_ID']
client_secret = ENV['GITHUB_CLIENT_SECRET']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, client_id, client_secret, scope: 'user, public_repo, admin:repo_hook'
end
