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
        flash[:danger] = msg
      end
      render 'admin/users/new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = t('update_user_success', name: @user.username)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :owner_id, :sales_id, :tech_id)
  end
end