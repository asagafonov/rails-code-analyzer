# frozen_string_literal: true

class Web::RepositoryChecksController < ApplicationController
  def create
    @repository = Repository.find(params[:id])
    @repository_check = Repository.repository_checks.build

    if @repository_check.save
      check_repository
      redirect_to @repository, notice: t('controllers.repository_checks.create.success')
    else
      redirect_to @repository, alert: t('controllers.repository_checks.create.failure')
    end
  end

  private

  def check_repository
    check_repository = ApplicationContainer[:check_repository]
    check_repository.run
  end
end
