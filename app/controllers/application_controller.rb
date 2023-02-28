# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    redirect_to root_path, alert: t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
  end
end
