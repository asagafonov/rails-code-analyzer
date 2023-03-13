# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'should return 200' do
    post api_checks_path, params: { repository: { github_id: 'example/Example' } }

    assert_response :success
  end
end
