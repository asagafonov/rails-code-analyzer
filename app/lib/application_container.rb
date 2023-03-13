# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit, -> { OctokitClientStub }
    register :check_repository, -> { CheckRepositoryCodeJobStub }
  else
    register :octokit, -> { OctokitClient }
    register :check_repository, -> { CheckRepositoryCodeJob }
  end
end
