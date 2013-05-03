class DashboardController < ApplicationController

  def index
    if user_signed_in?
      @updates = Notification.latest_for_user(current_user)
    else

    end
    

  end
end
