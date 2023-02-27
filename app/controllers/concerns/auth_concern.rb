# frozen_string_literal: true

module AuthConcern
  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.clear
  end

  def update_user_data(user, data)
    user.name = data[:name]
    user.nickname = data[:nickname]
    user.image_url = data[:image_url]
    user.token = data[:token]
  end
end
