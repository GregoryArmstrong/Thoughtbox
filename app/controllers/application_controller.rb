class ApplicationController < ActionController::Base
  before_action :authorize!

  helper_method :current_user

  protect_from_forgery with: :exception

  def current_user
    if cookies[:user_id]
      @current_user ||= User.find(cookies[:user_id])
    else
      @current_user ||= User.new
    end
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless current_permission.allow?(params[:controller], params[:action])
      flash[:notice] = "Page does not exist."
      redirect_to root_path
    end
  end

end
