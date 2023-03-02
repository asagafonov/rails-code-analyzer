# frozen_string_literal: true

class CheckRepositoryOperation
  def self.run
    pp 'I run eslint!'
  end
end

class CheckRepositoryOperationStub
  def self.run
    pp 'I pretend to run eslint, haha!'
  end
end
