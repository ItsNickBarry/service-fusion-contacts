require 'test_helper'

class Api::ContactsControllerTest < ActionDispatch::IntegrationTest
  describe Api::ContactsController do
    describe '#show' do
      it 'renders contact' do
        get api_contact_url contacts(:christian_winters)
        assert_response 200
        assert_template :show
      end
    end

    describe '#index' do
      it 'renders contacts' do
        get api_contacts_url
        assert_response 200
        assert_template :index
      end
    end

    describe '#create' do
      it 'creates and renders contact' do
        assert_difference 'Contact.count', 1 do
          post api_contacts_url, params: { contact: {
            first_name: 'fn', last_name: 'ln',
            emails_attributes: [{ body: 'email' }],
            phone_numbers_attributes: [{ body: 'phone_number' }],
          } }
        end
        assert_response 200
        assert_template :show
      end

      it 'renders error if contact is invalid' do
        assert_no_difference 'Contact.count' do
          post api_contacts_url, params: { contact: { data: nil } }
        end
        assert_response 422
      end
    end

    describe '#update' do
      it 'updates and renders contact' do
        patch api_contact_url(contacts(:christian_winters)), params: { contact: { first_name: 'cHrIsTiaN' } }
        assert_response 200
        assert_template :show
      end

      it 'renders error if contact is invalid' do
        @contact = contacts(:christian_winters)
        emails_attributes = @contact.emails.map { |e| { id: e.id, _destroy: true } }
        patch api_contact_url(@contact), params: { contact: { emails_attributes: emails_attributes } }
        assert_response 422
      end
    end

    describe '#destroy' do
      it 'destroys and renders contact' do
        delete api_contact_url contacts(:christian_winters)
        assert_response 200
        assert_template :show
      end
    end
  end
end
