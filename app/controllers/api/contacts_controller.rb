class Api::ContactsController < ApplicationController
  def show
    @contact = Contact.find params[:id]
  end

  def index
    @contacts = Contact.all
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      render :show
    else
      render_unprocessable_entity! @contact
    end
  end

  def update
    @contact = Contact.find params[:id]
    Contact.transaction do
      @contact.update contact_params
      if @contact.valid?
        render :show
      else
        render_unprocessable_entity! @contact
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    @contact = Contact.find params[:id]
    @contact.destroy
    render :show
  end

  private

    def contact_params
      params.require(:contact).permit(
        :first_name, :last_name, :date_of_birth,
        addresses_attributes: [:id, :body, :_destroy],
        emails_attributes: [:id, :body, :_destroy],
        phone_numbers_attributes: [:id, :body, :_destroy],
      )
    end
end
