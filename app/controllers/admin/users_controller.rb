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

  def edit
    @user = User.find(params[:id])
  end

  def update
    clean_user_params = user_params.delete_if{|k, v| v.blank?}
    @user = User.find(params[:id])
    if @user.update(clean_user_params)
      flash[:notice] = t('update_user_success', name: @user.username)
      redirect_to :back
    else
      flash[:notice] = @user.errors.full_messages.first
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :owner_id, :sales_id, :tech_id, :staff_number, :customer_number)
  end
end