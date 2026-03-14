class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
