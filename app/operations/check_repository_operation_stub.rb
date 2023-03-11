# frozen_string_literal: true

class CheckRepositoryOperationStub
  def self.run(check_id)
    repository_check = Repository::Check.find(check_id)

    10.times do
      linter_error = repository_check.linter_errors.build(
        file_path: [
          'app',
          'helpers/modal',
          'components/Data'
        ].sample,
        message: Faker::Lorem.sentence(word_count: 3),
        rule: Faker::Lorem.sentence(word_count: 3),
        location: "#{[10, 15, 20].sample}:#{[3, 4, 12].sample}",
      )

      linter_error.save
    end

    repository_check.mark_as_failed!
  end
end
