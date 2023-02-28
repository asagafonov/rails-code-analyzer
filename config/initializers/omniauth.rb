# frozen_string_literal: true

client_id = ENV.fetch('GITHUB_CLIENT_ID', nil)
client_secret = ENV.fetch('GITHUB_CLIENT_SECRET', nil)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, client_id, client_secret, scope: 'user, public_repo, admin:repo_hook'
end
