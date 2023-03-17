# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :bob
    sign_in @user

    @repo = repositories(:redux)
    @attrs = { github_id: 'example/Example' }
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

  test 'user should get new' do
    get new_repository_path
    assert_response :success
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

  test 'user should create repository, it should get updated' do
    post repositories_url, params: { repository: @attrs }

    repo = Repository.find_by(@attrs)

    assert repo
    assert { repo.name }
    assert { repo.language }
    assert { repo.full_name }
    assert { repo.clone_url }
    assert { repo.repo_created_at }
    assert { repo.repo_updated_at }
    assert_redirected_to repository_path(repo)
  end

  test 'unauthorized user should not create repositories' do
    sign_out

    post repositories_url, params: { repository: @attrs }

    repo = Repository.find_by(@attrs)
    assert_not repo
    assert_redirected_to root_path
  end
end
