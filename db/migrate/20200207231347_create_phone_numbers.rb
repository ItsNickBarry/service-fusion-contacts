class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.integer :contact_id

      t.string :body, null: false

      t.timestamps
    end

    add_index :phone_numbers, :contact_id
  end
end
