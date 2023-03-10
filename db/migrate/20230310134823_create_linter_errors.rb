class CreateLinterErrors < ActiveRecord::Migration[7.0]
  def change
    create_table :repository_check_linter_errors do |t|
      t.string :file_path
      t.string :message
      t.string :rule
      t.string :location
      t.references :check, null: false, foreign_key: { to_table: :repository_checks, on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
