class PagesController < ApplicationController
  def top
    redirect_to dashboard_path if user_signed_in?
  end
end
