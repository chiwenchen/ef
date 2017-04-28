class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    current_user.add_role params[:user][:role]
  end

  def update
    super
  end

  def after_sign_up_path_for(resource)
    landing_home_index_path
  end
end