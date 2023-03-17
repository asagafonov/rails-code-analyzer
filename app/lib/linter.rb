# frozen_string_literal: true

class Linter
  def self.lint_javascript(dir)
    config_path = Rails.root.join('.eslintrc.yml')
    command = "./node_modules/eslint/bin/eslint.js --format json -c #{config_path} --no-eslintrc #{dir}"
    terminal.run_command(command)
  end

  def self.lint_ruby(dir)
    config_path = Rails.root.join('config/.rubocop.yml')
    command = "rubocop --format json --config #{config_path} #{dir}"
    terminal.run_command(command)
  end

  private_class_method def self.terminal
    ApplicationContainer[:terminal]
  end
end
