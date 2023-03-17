# frozen_string_literal: true

class CheckRepositoryCodeJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    @repository_check = Repository::Check.find(check_id)
    return unless @repository_check

    @repository_check.start_checking!

    FetchLastCommitJob.perform_later(@repository_check.id)

    repository = @repository_check.repository
    directory = directory_path(repository.github_id)

    git_clone(repository.clone_url)
    result = Linter.public_send("lint_#{repository.language}", directory)
    parsed_result = JsonParser.public_send("parse_#{repository.language}", result).reject(&:empty?)

    if parsed_result.empty?
      @repository_check.update(passed: true)
    else
      write_linter_errors(@repository_check, parsed_result)
      @repository_check.update(passed: false)
      send_mailer(type: :fail, data: { check: @repository_check })
    end
    @repository_check.mark_as_finished!
  rescue StandardError => e
    send_mailer(type: :error, data: { repo: repository })
    @repository_check.update(passed: false)
    @repository_check.mark_as_failed!
    logger.error "Error in check repository job: #{e}"
  end

  private

  def directory_path(github_id)
    Rails.root.join("./tmp/repository_checks/#{github_id}/")
  end

  def git_clone(url)
    clear_dir_command = "rm -rf #{directory}"
    Terminal.run_command(clear_dir_command)

    clone_command = "git clone #{url} #{directory}"
    Terminal.run_command(clone_command)
  end

  def send_mailer(type:, data:)
    case type
    when :fail
      UserMailer.with(
        user: data[:check].repository.user,
        repo: data[:check].repository,
        check: data[:check]
      ).send_failed_email.deliver_now
    when :error
      UserMailer.with(
        user: data[:repo].user,
        repo: data[:repo]
      ).send_error_email.deliver_now
    else
      puts "No such mailer type as #{type}"
    end
  end

  def write_linter_errors(check, errors)
    errors.each do |error|
      new_error = check.linter_errors.build(
        file_path: error[0][:file_path],
        message: error[0][:message],
        rule: error[0][:rule],
        location: error[0][:location]
      )

      new_error.save!
    end
  end
end
