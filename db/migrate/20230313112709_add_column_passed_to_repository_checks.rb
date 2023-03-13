class AddColumnPassedToRepositoryChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :repository_checks, :passed, :boolean
  end
end
