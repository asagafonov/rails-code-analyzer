# frozen_string_literal: true

require 'test_helper'

class UpdateRepositoryJobTest < ActiveJob::TestCase
  test 'update created repo' do
    repo = repositories :react
    uri_template = Addressable::Template.new 'https://api.github.com/repos/{owner_name}/{repo_name}'

    response = load_fixture('files/response.json')

    stub_request(:get, uri_template)
      .to_return(
        status: 200,
        body: response,
        headers: { 'Content-Type' => 'application/json' }
      )

    old_name = repo.name

    UpdateRepositoryJob.perform_now repo.id
    repo.reload

    assert { repo.fetched? }
    assert { old_name != repo.name }
  end
end
