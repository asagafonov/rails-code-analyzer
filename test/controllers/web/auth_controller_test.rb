# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'check github auth' do
    post auth_request_path('github')
    assert_response :redirect
  end

  test 'should log in' do
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
    assert_response :redirect

    user = User.find_by!(email: auth_hash[:info][:email].downcase)

    assert user
    assert signed_in?
  end

  test 'should log out' do
    sign_in users(:bob)

    assert signed_in?
    get auth_logout_url
    assert_not signed_in?
  end
end
