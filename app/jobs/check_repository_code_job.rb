# frozen_string_literal: true

class CheckRepositoryCodeJob < ApplicationJob
  queue_as :default

  def perform(check_id, git_url)
    clone_repository(check_id, git_url)
  end

  private

  def clone_repository(check_id, url)
    directory = Rails.root.join("./tmp/repository_checks/check_#{check_id}")
    command = "git clone #{url} #{directory}"

    Open3.popen3(command)
  rescue StandardError
    puts 'Error cloning repository'
  end
end
