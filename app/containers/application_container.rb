# frozen_string_literal: true

require 'octokit'

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :fetch_repository_data, -> { FetchRepositoryDataOperationStub }
    register :check_repository, -> { CheckRepositoryOperationStub }
  else
    register :fetch_repository_data, -> { FetchRepositoryDataOperation }
    register :check_repository, -> { CheckRepositoryOperation }
  end
end
