class AddAttributesToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :github_id, :string
    add_column :repositories, :clone_url, :string
    add_column :repositories, :default_branch, :string
    add_column :repositories, :repo_created_at, :string
    add_column :repositories, :repo_updated_at, :string
  end
end
