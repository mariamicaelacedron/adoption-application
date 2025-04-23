class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_pets_path
    else
      super
    end
  end
end