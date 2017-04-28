class StaffsController < UsersController
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
end