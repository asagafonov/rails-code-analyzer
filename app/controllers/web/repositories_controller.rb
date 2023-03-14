# frozen_string_literal: true

require 'octokit'

module Web
  class RepositoriesController < ApplicationController
    def index
      authorize Repository
      @repositories = current_user&.repositories&.by_creation_date_desc
    end

    def show
      @repository = Repository.find(params[:id])
      authorize @repository

      @repository_checks = @repository.checks.by_creation_date_desc
      UpdateRepositoryJob.perform_later(@repository)
    end

    def new
      authorize Repository
      @repository = Repository.new
      @repositories_list = github_api(current_user).fetch_repositories
    end

    def create
      authorize Repository

      @repository = current_user.repositories.build(permitted_params)

      if @repository.save
        UpdateRepositoryJob.perform_later(@repository)
        SetupRepoHookJob.perform_later(@repository)

        redirect_to @repository, notice: t('controllers.repositories.create.success')
      else
        redirect_to new_repository_path, alert: t('controllers.repositories.create.failure')
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:github_id)
    end

    def github_api(user)
      ApplicationContainer[:octokit].new(user)
    end
  end
end
