class AddAndUpdateChecksAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :repository_checks, :last_commit_url, :string
    rename_column :repository_checks, :commit_id, :last_commit_sha
  end
end
