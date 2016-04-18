class PermissionService

  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user.registered_user?
      registered_user_permissions
    else
      guest_permissions
    end
  end

  def registered_user_permissions
    return true if controller == "welcome" && action == "index"
    return true if controller == "users" && action == "new"
    return true if controller == "links" && action == "index"
    return true if controller == "sessions" && action == "destroy"
  end

  def guest_permissions
    return true if controller == "welcome" && action == "index"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
  end

end
