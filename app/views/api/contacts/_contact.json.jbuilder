json.extract! contact, :id, :first_name, :last_name, :date_of_birth

json.addresses contact.addresses, :id, :body
json.emails contact.emails, :id, :body
json.phone_numbers contact.phone_numbers, :id, :body
