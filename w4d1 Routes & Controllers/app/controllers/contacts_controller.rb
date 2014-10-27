class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: (
      user.contacts + user.shared_contacts     
    )
  end
  
  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render_error(contact)
    end
  end
  
  def show
    render json: Contact.find(params[:id])
  end
  
  def update
    contact = Conact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render_error(contact)
    end
  end
  
  def destroy
    contact = Conact.find(params[:id])
    contact.destroy!
    render json: contact
  end
  
  private
  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
  
  def render_error(contact)
    render(
      json: contact.errors.full_messages, status: :unprocessable_entity
    )
  end
end
