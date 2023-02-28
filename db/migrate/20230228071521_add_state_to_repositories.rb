class AddStateToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :state, :string
  end
end
