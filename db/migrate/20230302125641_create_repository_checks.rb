class CreateRepositoryChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :repository_checks do |t|
      t.string :commit_id

      t.timestamps
    end
  end
end
