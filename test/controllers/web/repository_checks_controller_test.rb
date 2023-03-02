require "test_helper"

class Web::RepositoryChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get web_repository_checks_create_url
    assert_response :success
  end

  test "should get update" do
    get web_repository_checks_update_url
    assert_response :success
  end
end
