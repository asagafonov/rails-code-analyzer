# frozen_string_literal: true

class Linter
  class << self
    def lint_javascript(dir)
      config_path = Rails.root.join('.eslintrc.yml')
      command = "./node_modules/eslint/bin/eslint.js --format json -c #{config_path} --no-eslintrc #{dir}"
      Terminal.run_command(command)
    end

    def lint_ruby(dir)
      config_path = Rails.root.join('config/.rubocop.yml')
      command = "rubocop --format json --config #{config_path} #{dir}"
      Terminal.run_command(command)
    end
  end
end
