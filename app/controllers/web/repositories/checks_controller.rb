# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @repository_check = Repository::Check.find(params[:id])
        @linter_errors = @repository_check.linter_errors
      end

      def create
        @repository = Repository.find(params[:repository_id])
        @repository_check = Repository::Check.new(repository_id: @repository.id)

        if @repository_check.save
          FetchLastCommitJob.perform_later(@repository_check.id)
          check_repository(@repository_check.id)
          redirect_to @repository, notice: t('controllers.repository_checks.create.success')
        else
          redirect_to @repository, alert: t('controllers.repository_checks.create.failure')
        end
      end

      private

      def check_repository(check_id)
        check_repository = ApplicationContainer[:check_repository]
        check_repository.run(check_id)
      end
    end
  end
end
