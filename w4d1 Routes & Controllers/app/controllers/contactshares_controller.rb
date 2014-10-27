class ContactsharesController < ApplicationController
  def create
    contact_share = ContactShare.new(contact_share_params)
    if contact_share.save
      render json: contact_share
    else
      render_error(contact_share)
    end
  end
  
  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.destroy!
    render json: contact_share
  end
  
  private
  def contact_share_params
    params[:contactshare].permit(:user_id, :contact_id)
  end
end
