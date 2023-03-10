# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :fetch_repository_data, -> { FetchRepositoryDataOperationStub }
    register :fetch_last_commit, -> { FetchLastCommitOperationStub }
    register :check_repository, -> { CheckRepositoryOperationStub }
  else
    register :fetch_repository_data, -> { FetchRepositoryDataOperation }
    register :fetch_last_commit, -> { FetchLastCommitOperation }
    register :check_repository, -> { CheckRepositoryOperation }
  end
end
