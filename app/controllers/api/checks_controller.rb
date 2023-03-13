# frozen_string_literal: true

module Api
  class ChecksController < ApplicationController
    def run_hook
      repo_link = params[:repository][:full_name]
      repository = Repository.find_by(github: repo_link)
      return unless repository

      repository_check = repository.checks.build
      repository_check.save

      check_repository(repository_check.id)
      render json: { status: 200 }
    end

    private

    def check_repository(check_id)
      check_repository = ApplicationContainer[:check_repository]
      check_repository.perform_later(check_id)
    end
  end
end
