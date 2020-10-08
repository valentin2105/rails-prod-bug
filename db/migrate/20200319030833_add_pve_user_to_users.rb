class AddPveUserToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :proxmox_user, :string
  end
end
