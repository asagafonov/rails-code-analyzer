# frozen_string_literal: true

require 'test_helper'

class FetchLastCommitJobTest < ActiveJob::TestCase
  setup do
    @repo = repositories(:react)
  end

  test 'fetch commit job fires' do
    FetchLastCommitJob.perform_later(@repo.id)

    assert_enqueued_with(
      job: FetchLastCommitJob,
      args: [@repo.id],
      queue: 'default'
    )
  end
end
