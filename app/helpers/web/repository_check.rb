# frozen_string_literal: true

class RepositoryCheckHelper
  def self.check_result(state)
    case state
    when 'passed'
      t('activerecord.attributues.repository_check.passed')
    when 'failed'
      t('activerecord.attributes.repository_check.failed')
    else
      t('activerecord.attributes.repository_check.unknown')
    end
  end
end
