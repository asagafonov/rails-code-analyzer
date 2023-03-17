# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryCodeJobTest < ActiveJob::TestCase
  setup do
    @check = repository_checks(:one)
  end

  test 'check repository job fires' do
    CheckRepositoryCodeJob.perform_later(@check.id)

    assert_enqueued_with(
      job: CheckRepositoryCodeJob,
      args: [@check.id],
      queue: 'default'
    )
  end
end
