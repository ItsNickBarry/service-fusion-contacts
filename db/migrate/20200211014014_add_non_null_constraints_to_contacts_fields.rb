class AddNonNullConstraintsToContactsFields < ActiveRecord::Migration[6.0]
  def change
    change_column :contacts, :first_name, :string, null: false
    change_column :contacts, :last_name, :string, null: false
    change_column :contacts, :date_of_birth, :date, null: false
  end
end
