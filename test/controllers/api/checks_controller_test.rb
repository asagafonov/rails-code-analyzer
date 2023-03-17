# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repo = repositories(:redux)
  end

  test 'should return :ok and create check' do
    prev_last_check = @repo.checks.last
    post api_checks_path, params: { repository: { full_name: @repo[:full_name] } }

    last_check = @repo.checks.last

    assert_response :ok
    assert { last_check.id != prev_last_check.id }
    assert { last_check.finished? }
    assert { last_check.passed }
  end
end
