require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  before do
    @contact = Contact.create({
      first_name: 'fn', last_name: 'ln',
      addresses_attributes: [{ body: 'address' }],
      emails_attributes: [{ body: 'email' }],
      phone_numbers_attributes: [{ body: 'phone_number' }],
    })
  end

  describe Contact do
    it 'is valid' do
      assert @contact.valid?
    end

    it 'does not require addresses' do
      @contact.addresses.delete_all
      assert @contact.valid?
    end

    it 'must have at least one email' do
      @contact.emails.delete_all
      refute @contact.valid?
    end

    it 'must have at least one phone number' do
      @contact.phone_numbers.delete_all
      refute @contact.valid?
    end
  end
end
