class AddNameAndLanguageToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :name, :string
    add_column :repositories, :language, :string
  end
end
