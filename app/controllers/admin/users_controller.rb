class Admin::UsersController < AdminController

  def new
    
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      @user.add_role params[:user][:role]
      @user.send_reset_password_instructions
      # sign_out current_user
      # sign_in @user
      flash[:notice] = t('add_new_user_success', name: @user.username)
      redirect_to new_admin_user_path
    else
      @user.errors.full_messages.each do |msg|
        flash[:notice] = msg
      end
      render 'devise/registrations/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end