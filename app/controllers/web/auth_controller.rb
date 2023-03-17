# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      email = auth[:email]
      user_data = auth.except(:email)

      redirect_to root_path, alert: t('views.auth.actions.login.failure') and return unless email

      start_session(email, user_data)
    end

    def end_session
      sign_out
      redirect_to root_path, notice: t('views.auth.actions.logout.success')
    end

    private

    def start_session(email, data)
      user = User.find_or_initialize_by(email:)
      update_user_data(user, data)

      if user.save
        sign_in(user)
        redirect_to root_path, notice: t('views.auth.actions.login.success')
      else
        redirect_to root_path, alert: t('views.auth.actions.save_user.failure')
      end
    end

    def auth
      data = request.env['omniauth.auth']
      {
        email: data[:info][:email],
        nickname: data[:info][:nickname],
        token: data[:credentials][:token]
      }
    end

    def update_user_data(user, data)
      user.nickname = data[:nickname]
      user.token = data[:token]
    end
  end
end
