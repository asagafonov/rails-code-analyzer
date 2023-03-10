class AddLinterErrorsCountToRepositoryChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :repository_checks, :linter_errors_count, :integer
  end
end
