class AddUserToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_reference :repositories, :user, null: false, foreign_key: true, index: true
  end
end
