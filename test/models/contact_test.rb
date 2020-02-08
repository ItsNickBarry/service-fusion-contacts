require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  before do
    @contact = contacts(:christian_winters)
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
