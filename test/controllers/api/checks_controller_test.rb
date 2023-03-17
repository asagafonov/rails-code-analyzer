# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repo = repositories(:redux)
  end

  test 'should return 200' do
    post api_checks_path, params: { repository: { full_name: @repo[:full_name] } }

    assert_response :ok
  end
end
