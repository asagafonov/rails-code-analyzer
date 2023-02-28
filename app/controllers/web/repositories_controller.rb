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

      return if @repository.fetched?

      UpdateRepositoryJob.perform_now(@repository.id)
    end

    def new
      authorize Repository
      @repository = Repository.new

      client = Octokit::Client.new(
        access_token: current_user.token,
        auto_paginate: true
      )

      @repositories_list = client.repos.filter { |r| Repository.language.values.collect(&:text).include?(r[:language]) }
    end

    def create
      @repository = current_user.repositories.build(permitted_params)
      authorize @repository

      if @repository.save
        UpdateRepositoryJob.perform_now(@repository.id)
        redirect_to @repository, notice: t('controllers.repositories.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:github)
    end
  end
end
