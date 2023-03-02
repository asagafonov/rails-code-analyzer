# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
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
  end
end