class IndexContactsUniquelyOnFirstNameAndLastName < ActiveRecord::Migration[6.0]
  def change
    add_index :contacts, [:last_name, :first_name], unique: true
  end
end
