# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :bob
    sign_in @user

    @repo = repositories(:redux)
  end

  test 'should get index' do
    get repositories_path

    assert_response :success
  end

  test 'unauthorized user should not get index' do
    sign_out

    get repositories_path
    assert_redirected_to root_path
  end

  test 'should get repositories list at new' do
    uri_template = Addressable::Template.new 'https://api.github.com/user/repos?per_page=100'

    response = load_fixture('files/repositories.json')

    stub_request(:get, uri_template)
      .to_return(
        status: 200,
        body: response,
        headers: { 'Content-Type' => 'application/json' }
      )

    get new_repository_path

    json = JSON.parse(response)

    assert_response :success
    assert { json&.length&.positive? }
  end

  test 'unauthorized user should not get new' do
    sign_out

    get new_repository_path
    assert_redirected_to root_path
  end

  test 'user should get show' do
    get repository_path(@repo)

    assert_response :success
  end

  test 'unauthorized user should not access show' do
    sign_out

    get repository_path(@repo)
    assert_redirected_to root_path
  end
end
