class AddNetboxTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :netbox_token, :string
  end
end
