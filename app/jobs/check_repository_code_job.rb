# frozen_string_literal: true

class CheckRepositoryCodeJob < ApplicationJob
  queue_as :default

  def perform(check_id, git_url)
    clone_repository(check_id, git_url)
  end

  private

  def clone_repository(check_id, url)
    command = "git clone #{url} tmp/repository_checks/#{check_id}"
    stdout, exit_status = Open3.popen3(command) do |_stdin, stdout, _stderr, wait_thr|
      [stdout.read, wait_thr.value]
    end

    exit_status.exitstatus
    puts stdout
  end
end
