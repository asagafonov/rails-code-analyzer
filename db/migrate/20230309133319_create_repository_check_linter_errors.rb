class CreateRepositoryCheckLinterErrors < ActiveRecord::Migration[7.0]
  def change
    create_table :repository_check_linter_errors do |t|
      t.string :file_path
      t.string :message
      t.string :rule
      t.string :location
      t.references :check, null: false, foreign_key: true

      t.timestamps
    end
  end
end
