# frozen_string_literal: true

class CheckRepositoryCodeJobStub < ApplicationJob
  queue_as :default

  def perform(check_id)
    repository_check = Repository::Check.find(check_id)

    repository_check.start_checking!
    repository_check.finish!
    repository_check.update(passed: true)
  end
end
