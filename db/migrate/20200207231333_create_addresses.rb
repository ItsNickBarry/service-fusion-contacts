class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :contact_id

      t.string :body, null: false

      t.timestamps
    end

    add_index :addresses, :contact_id
  end
end
