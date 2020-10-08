class AddMmonitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mmonit_username, :string
    add_column :users, :mmonit_password, :string
  end
end
