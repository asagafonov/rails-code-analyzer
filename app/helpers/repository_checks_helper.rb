# frozen_string_literal: true

module RepositoryChecksHelper
  def self.check_result(state)
    case state
    when 'passed'
      ::I18n.t('activerecord.attributues.repository/check.passed')
    when 'failed'
      ::I18n.t('activerecord.attributes.repository/check.failed')
    else
      ::I18n.t('activerecord.attributes.repository/check.unknown')
    end
  end
end
