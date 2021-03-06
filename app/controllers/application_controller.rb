class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def set_current_user
    @user = current_user if current_user
  end

  def check_organization
    @organization = Organization.friendly.find(params[:organization_id]) if params.has_key?(:organization_id)
  end
end
