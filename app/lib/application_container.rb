# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit, -> { OctokitClientStub }
    register :terminal, -> { TerminalStub }
  else
    register :octokit, -> { OctokitClient }
    register :terminal, -> { Terminal }
  end
end
