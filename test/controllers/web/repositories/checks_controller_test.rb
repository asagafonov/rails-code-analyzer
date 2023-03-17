# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :bob
    sign_in @user

    @repo = repositories(:redux)
    @check = repository_checks(:two)
  end

  test 'user should access show' do
    get repository_check_path(@repo, @check)

    assert_response :success
  end

  test 'unauthorized should not access show' do
    sign_out
    get repository_check_path(@repo, @check)

    assert_redirected_to root_path
  end

  test 'user should create check' do
    prev_last_check = @repo.checks.last
    post repository_checks_url(@repo)

    last_check = @repo.checks.last
    assert { prev_last_check.id != last_check.id }
    assert { last_check.finished? }
    assert { last_check.passed }
    assert_redirected_to @repo
  end

  test 'unauthorized user should not create check' do
    sign_out

    prev_last_check = @repo.checks.last
    post repository_checks_url(@repo)

    last_check = @repo.checks.last

    assert { prev_last_check.id == last_check.id }
    assert_redirected_to root_path
  end
end
