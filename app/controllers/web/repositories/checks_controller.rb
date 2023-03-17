# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @repository_check = Repository::Check.find(params[:id])
        authorize @repository_check
        @linter_errors = @repository_check.linter_errors
      end

      def create
        authorize Repository::Check
        @repository = Repository.find(params[:repository_id])
        @repository_check = @repository.checks.build

        if @repository_check.save
          CheckRepositoryCodeJob.perform_later(@repository_check.id)
          redirect_to @repository, notice: t('controllers.repository_checks.create.success')
        else
          redirect_to @repository, alert: t('controllers.repository_checks.create.failure')
        end
      end
    end
  end
end
