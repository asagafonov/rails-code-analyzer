# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'code-analyzer@example.com'

  def send_failed_email
    @user = params[:user]
    @repo = params[:repo]
    @check = params[:check]
    mail(to: @user.email, subject: t('mailers.repository_checks.failed.subject'))
  end

  def send_error_email
    @user = params[:user]
    @repo = params[:repo]
    mail(to: @user.email, subject: t('mailers.repository_checks.error.subject'))
  end
end
