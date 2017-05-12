class UsersController < ApplicationController
  # before_action :set_user, except: [:edit, :update]
  
  # def edit; end

  # def update; end

  # def send_mobile_token
  #   @user.generate_and_send_mobile_token
  #   redirect_to confirm_mobile_token_user_path(@user)
  # end

  # def confirm_mobile_token; end

  # def verify_mobile_token
  #   mobile_token = params[:user][:mobile_confirmation_token]
  #   if verify_mobile_token_and_update_mobile(mobile_token)
  #     flash[:notice] = "認證成功"
  #     redirect_to root_path
  #   else
  #     flash[:error] = "認證碼錯誤，請重新輸入"
  #     render :confirm_mobile_token
  #   end
  # end

  # private

  # def set_user
  #   @user = User.find(params[:id]) 
  # end

  def new
    render 'devise/registrations/new'
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      @user.add_role params[:user][:role]
      sign_out current_user
      sign_in @user
      redirect_to root_path
    else
      @user.errors.full_messages.each do |msg|
        flash[:notice] = msg
      end
      render 'devise/registrations/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end


end