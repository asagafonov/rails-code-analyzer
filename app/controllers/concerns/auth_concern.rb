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
end
