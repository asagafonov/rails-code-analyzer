# frozen_string_literal: true

class JsonParser
  def self.parse_javascript(data)
    return [] if data.empty?

    JSON.parse(data).map do |check_data|
      file_path = check_data['filePath']
      format_javascript_errors(check_data['messages'], file_path)
    end
  end

  def self.parse_ruby(data)
    return [] if data.empty?

    JSON.parse(data)['files'].filter { |d| d.offences.any? }.map do |check_data|
      file_path = check_data['path']
      format_ruby_errors(check_data['offences'], file_path)
    end
  end

  private_class_method def self.format_javascript_errors(error_messages, file_path)
    error_messages.map do |message|
      {
        file_path:,
        message: message['message'],
        rule: message['ruleId'],
        location: "#{message['line']} : #{message['column']}"
      }
    end
  end

  private_class_method def self.format_ruby_errors(error_messages, file_path)
    error_messages.map do |message|
      {
        file_path:,
        message: message['message'],
        rule: message['cop_name'],
        location: "#{message['location']['line']} : #{message['location']['column']}"
      }
    end
  end
end
