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
    end

    def new
      authorize Repository
      @repository = Repository.new
      @repositories_list = github_api(current_user).fetch_repositories

      UpdateRepositoryJob.perform_later(@repository.id)
    end

    def create
      authorize Repository

      if Repository.find_by(github_id: permitted_params[:github_id])
        redirect_to repositories_path, alert: t('controllers.repositories.create.already_exists') and return
      end

      @repository = current_user.repositories.build(permitted_params)

      if @repository.save
        UpdateRepositoryJob.perform_later(@repository.id)
        github_api(@repository.user).create_hook(@repository.github_id)

        redirect_to @repository, notice: t('controllers.repositories.create.success')
      else
        render :new, status: :unprocessable_entity
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
