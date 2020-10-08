class AddPvePasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :proxmox_password, :string
  end
end
