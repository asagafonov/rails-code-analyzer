class AddGitUrlToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :git_url, :string
  end
end
