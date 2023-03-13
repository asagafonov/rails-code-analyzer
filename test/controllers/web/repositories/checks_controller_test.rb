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
    prev_check = @repo.checks.last
    post repository_checks_url(@repo)

    new_check = @repo.checks.last
    assert { prev_check&.id != new_check&.id }
    assert_redirected_to @repo
  end

  test 'unauthorized user should not create check' do
    sign_out

    prev_check = @repo.checks.last
    post repository_checks_url(@repo)

    new_check = @repo.checks.last
    assert { prev_check&.id == new_check&.id }
    assert_redirected_to root_path
  end
end
