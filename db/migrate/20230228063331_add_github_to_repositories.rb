class AddGithubToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :github, :string
  end
end
