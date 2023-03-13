# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryCodeJobTest < ActiveJob::TestCase
  setup do
    @check = repository_checks(:one)
    @check_repo_job = ApplicationContainer[:check_repository]
  end

  test 'check repository job fires' do
    @check_repo_job.perform_later(@check.id)

    assert_enqueued_with(
      job: CheckRepositoryCodeJobStub,
      args: [@check.id],
      queue: 'default'
    )
  end
end
