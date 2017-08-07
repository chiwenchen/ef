class UsersController < ApplicationController
  def edit
  end

  def update
    current_user.update(user_params)
    flash[:notice] = t('update_user_success', name: current_user.username)
    redirect_to :back
  end

  def reset_password
    user = current_user

    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(validate: false)

    sign_out(current_user)
    
    redirect_to edit_password_path(user, reset_password_token: raw, user_id: user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end