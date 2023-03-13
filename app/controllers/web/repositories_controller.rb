# frozen_string_literal: true

require 'octokit'

module Web
  class RepositoriesController < ApplicationController
    def index
      authorize Repository
      @repositories = current_user&.repositories&.all
    end

    def show
      @repository = Repository.find(params[:id])
      authorize @repository

      @repository_checks = @repository.checks.by_creation_date_desc

      UpdateRepositoryJob.perform_later(@repository.id)
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
        UpdateRepositoryJob.perform_later(@repository.id)
        redirect_to @repository, notice: t('controllers.repositories.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:full_name)
    end

    def github_api(user)
      ApplicationContainer[:octokit].new(user)
    end
  end
end
