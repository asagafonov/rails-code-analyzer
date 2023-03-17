# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'code-analyzer@example.com'

  def send_failed_email
    @check = params[:check]
    @repo = @check.repository
    @user = @repo.user
    mail(to: @user.email, subject: t('mailers.repository_checks.failed.subject'))
  end

  def send_error_email
    @repo = params[:repo]
    @user = @repo.user
    mail(to: @user.email, subject: t('mailers.repository_checks.error.subject'))
  end
end
