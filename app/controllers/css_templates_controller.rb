class CssTemplatesController < ApplicationController
  before_filter :authenticate_user!

  def show
    if params[:id] == "custom"
      if current_user.css
        render :text => current_user.css.css
      else
        render :file => "/css_templates/default.css"
      end
    else
      render :file => "/css_templates/#{params[:id]}.css"
    end
  end

  def create
    current_user.css.destroy if current_user.css
    current_user.create_css({css: params[:css]})
    render :json => {status: "ok"}
  end
end
