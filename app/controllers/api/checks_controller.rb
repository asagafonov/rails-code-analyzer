# frozen_string_literal: true

module Api
  class ChecksController < ApplicationController
    def create
      repo_link = params[:repository][:full_name]
      repository = Repository.find_by(full_name: repo_link)
      return unless repository

      repository_check = repository.checks.build
      repository_check.save

      CheckRepositoryCodeJob.perform_later(repository_check.id)
      render json: { status: :ok }
    end
  end
end
