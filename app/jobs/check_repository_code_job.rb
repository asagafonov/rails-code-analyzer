# frozen_string_literal: true

class CheckRepositoryCodeJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    @repository_check = Repository::Check.find_by(id: check_id)
    repository = @repository_check.repository
    url = git_url(repository.github)

    @repository_check.start_checking!

    git_clone(url)
    result = Linter.public_send("lint_#{repository.language}", directory)
    parsed_result = JsonParser.public_send("parse_#{repository.language}", result)

    if parsed_result.empty?
      @repository_check.mark_as_passed!
    else
      CheckErrorBuilder.write(check_id, parsed_result)
      @repository_check.mark_as_failed!
    end
  rescue StandardError
    @repository_check.raise_error!
  end

  private

  def directory
    Rails.root.join('./tmp/repository_check')
  end

  def git_clone(url)
    clear_dir_command = "rm -rf #{directory}"
    Terminal.run_command(clear_dir_command)

    clone_command = "git clone #{url} #{directory}"
    Terminal.run_command(clone_command)
  end

  def git_url(url)
    "https://github.com/#{url}.git"
  end
end
