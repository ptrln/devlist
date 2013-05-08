class CssTemplatesController < ApplicationController
  def show
    render :file => "/css_templates/#{params[:id]}.css"
  end
end
