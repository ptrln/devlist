class DashboardController < ApplicationController

  def index
    @visitors = Analytical.sum(:visitors)
    @pageviews = Analytical.sum(:pageviews)
    if user_signed_in?
      @updates = Notification.latest_for_user(current_user)
      render :index
    else
      render :new_user
    end
  end
end
