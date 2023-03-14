# frozen_string_literal: true

require 'test_helper'

class SetupRepoHookJobTest < ActiveJob::TestCase
  setup do
    @repo = repositories(:react)
  end

  test 'repo hook setup job fires' do
    SetupRepoHookJob.perform_later(@repo)

    assert_enqueued_with(
      job: SetupRepoHookJob,
      args: [@repo],
      queue: 'default'
    )
  end
end
