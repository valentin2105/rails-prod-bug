class AddRundeckTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rundeck_token, :string
  end
end
