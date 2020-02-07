class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.integer :contact_id

      t.string :body, null: false

      t.timestamps
    end

    add_index :emails, :contact_id
  end
end
