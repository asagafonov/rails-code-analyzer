# frozen_string_literal: true

require 'mailtrap'

class UserMailer < ApplicationMailer
  default from: 'code-analyzer@example.com'

  def send_email
    @user = params[:user]
    @check = params[:check]
    mail(to: @user.email, subject: t('mailers.repository_checks.failed.subject'))
  end
end
