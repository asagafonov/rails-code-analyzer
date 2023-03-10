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

      fetch_repository_data(@repository.id)

      @repository_checks = Repository::Check.where(repository_id: @repository.id).by_creation_date_desc
    end

    def new
      authorize Repository
      @repository = Repository.new
      @repositories_list = OctokitClient.new(current_user).fetch_repositories
    end

    def create
      @repository = current_user.repositories.build(permitted_params)
      authorize @repository

      if @repository.save
        fetch_repository_data(@repository.id)
        redirect_to @repository, notice: t('controllers.repositories.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:github)
    end

    def fetch_repository_data(repository_id)
      fetch_repository_data = ApplicationContainer[:fetch_repository_data]
      fetch_repository_data.run(repository_id)
    end
  end
end
