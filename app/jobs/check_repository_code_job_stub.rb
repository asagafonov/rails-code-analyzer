# frozen_string_literal: true

class CheckRepositoryCodeJobStub < ApplicationJob
  queue_as :default

  def perform(check_id)
    repository_check = Repository::Check.find(check_id)

    repository_check.start_checking!

    20.times do
      linter_error = repository_check.linter_errors.build(
        file_path: [
          'app',
          'helpers/modal',
          'components/Data'
        ].sample,
        message: Faker::Lorem.sentence(word_count: 3),
        rule: Faker::Lorem.sentence(word_count: 1),
        location: "#{[10, 15, 20].sample}:#{[3, 4, 12].sample}"
      )

      linter_error.save
    end

    repository_check.finish!
    repository_check.update(passed: false)
  end
end
