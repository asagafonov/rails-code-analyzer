# frozen_string_literal: true

class CheckErrorBuilder
  class << self
    def write(check_id, errors)
      @repository_check = Repository::Check.find(check_id)

      errors.each do |error|
        @repository_check.linter_errors.build(
          file_path: error['file_path'],
          message: error['message'],
          rule: error['rule'],
          line_column: error['line_column']
        )

        @repository_check.save!
      end
    end
  end
end
