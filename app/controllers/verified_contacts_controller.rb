class VerifiedContactsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    contact = UserVerifiedContact.find(params[:id])
    if current_user == contact.user
      contact.destroy
      respond_to do |format|
        format.html { redirect_to edit_profile_path }
        format.json { render :json => { status: "ok" } }
      end
    else
      render :status => :forbidden
    end
  end
end
