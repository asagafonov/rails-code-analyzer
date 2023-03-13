class RenameRepositoriesGithubToFullName < ActiveRecord::Migration[7.0]
  def change
    rename_column :repositories, :github, :full_name
  end
end
