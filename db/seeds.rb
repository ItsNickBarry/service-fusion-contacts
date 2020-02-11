# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def phone_number
  "+" + (0..(1 + rand(3))).map { rand 1000 }.join(' ')
end

Contact.create!({
  first_name: 'Gladwin', last_name: 'Jebb', date_of_birth: Date.new(1900, 4, 29),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Gladwin@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Trygve', last_name: 'Lie', date_of_birth: Date.new(1896, 7, 16),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Trygve@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Dag', last_name: 'Hammarskjöld', date_of_birth: Date.new(1905, 7, 29),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Dag@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'U', last_name: 'Thant',
  addresses_attributes: [{ body: 'Burma' }, { body: 'Myanmar' }], date_of_birth: Date.new(1909, 1, 22),
  emails_attributes: [{ body: 'U@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Kurt', last_name: 'Waldheim', date_of_birth: Date.new(1918, 12, 21),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Kurt@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Javier', last_name: 'Pérez de Cuéllar', date_of_birth: Date.new(1920, 1, 19),
  addresses_attributes: [{ body: 'Peru' }],
  emails_attributes: [{ body: 'Javier@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Boutros', last_name: 'Boutros-Ghali', date_of_birth: Date.new(1922, 11, 14),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Boutros@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Kofi', last_name: 'Annan', date_of_birth: Date.new(1938, 4, 8),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Kofi@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'Ban', last_name: 'Ki-moon', date_of_birth: Date.new(1944, 6, 13),
  addresses_attributes: [],
  emails_attributes: [{ body: 'Ban@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})

Contact.create!({
  first_name: 'António', last_name: 'Guterres', date_of_birth: Date.new(1949, 4, 30),
  addresses_attributes: [],
  emails_attributes: [{ body: 'António@example.com' }],
  phone_numbers_attributes: [{ body: phone_number }, { body: phone_number }],
})
