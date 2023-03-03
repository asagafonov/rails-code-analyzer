# frozen_string_literal: true

class CheckRepositoryOperation
  def self.run(check_id, git_url)
    CheckRepositoryCodeJob.perform_later(check_id, git_url)
  end
end

class CheckRepositoryOperationStub
  def self.run
    pp 'I pretend to run eslint, haha!'
  end
end
