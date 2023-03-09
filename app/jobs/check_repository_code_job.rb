# frozen_string_literal: true

class CheckRepositoryCodeJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    @repository_check = Repository::Check.find_by(id: check_id)
    repository = @repository_check.repository
    url = git_url(repository.github)

    @repository_check.start_checking!

    git_clone(url)
    result = check(repository)

    puts '@result'
    puts JSON.parse(result)
    @repository_check.mark_as_failed!
  rescue StandardError
    @repository_check.raise_error!
  end

  private

  def directory
    Rails.root.join('./tmp/repository_check')
  end

  def git_clone(url)
    clear_dir_command = "rm -rf #{directory}"
    run_command(clear_dir_command)

    clone_command = "git clone #{url} #{directory}"
    run_command(clone_command)
  end

  def check(repository)
    check_command = Linter.lint(repository.language, directory)
    run_command(check_command)
  end

  def run_command(command)
    output, status = Open3.popen3(command) do |_stdin, stdout, _stderr, wait_thr|
      [stdout.read, wait_thr.value.exitstatus]
    end

    return output unless status.to_i.zero?

    ''
  end

  def git_url(url)
    "https://github.com/#{url}.git"
  end

  class Linter
    def self.lint(lang, path)
      case lang
      when 'javascript'
        config_path = Rails.root.join('.eslintrc.yml')
        "./node_modules/eslint/bin/eslint.js --format json -c #{config_path} --no-eslintrc #{path}"
      else
        raise "#{lang} language is not supported"
      end
    end
  end
end
