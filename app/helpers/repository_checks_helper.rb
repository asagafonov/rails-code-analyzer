# frozen_string_literal: true

module RepositoryChecksHelper
  def self.check_result(state)
    case state
    when 'passed'
      ::I18n.t('activerecord.attributes.repository/check.passed')
    when 'failed'
      ::I18n.t('activerecord.attributes.repository/check.failed')
    else
      ::I18n.t('activerecord.attributes.repository/check.unknown')
    end
  end

  def self.group_errors_by_path(errors)
    return {} if errors.empty?

    errors.each_with_object({}) do |err, acc|
      path = err&.file_path

      acc[path] ||= []
      acc[path] << { rule: err&.rule, message: err&.message, location: err&.location }
    end
  end
end
