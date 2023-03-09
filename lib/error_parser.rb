# frozen_string_literal: true

class ErrorParser
  class << self
    def parse_javascript(data)
      return [] if data.empty?

      JSON.parse(data).map do |check_data|
        file_path = check_data['filePath']
        errors = parse_javascript_errors(check_data['messages'])
        { file_path:, errors: }
      end
    end

    def parse_ruby(data)
      return [] if data.empty?

      JSON.parse(data)['files'].filter { |d| d.offences.any? }.map do |check_data|
        file_path = check_data['path']
        errors = parse_ruby_errors(check_data['offences'])
        { file_path:, errors: }
      end
    end

    def parse_javascript_errors(error_messages)
      error_messages.map do |message|
        {
          message: message['message'],
          rule: message['ruleId'],
          line_column: "#{message['line']} : #{message['column']}"
        }
      end
    end

    def parse_ruby_errors(error_messages)
      error_messages.map do |message|
        {
          message: message['message'],
          rule: message['cop_name'],
          line_column: "#{message['location']['line']} : #{message['location']['column']}"
        }
      end
    end
  end
end
