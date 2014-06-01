class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :owner_id
      t.integer :owned_id

      t.timestamps
    end

    add_index :ownerships, :owner_id
    add_index :ownerships, :owned_id
    add_index :ownerships, [:owner_id, :owned_id], unique: true
  end
end
