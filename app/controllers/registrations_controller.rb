# class RegistrationsController < Devise::RegistrationsController

#   # before_action :is_admin?, only: [:new, :create]

#   def new
#     binding.pry
#     super
#   end

#   def create
#     super
#     current_user.add_role params[:user][:role]
#   end

#   def update
#     super
#   end

#   def after_sign_up_path_for(resource)
#     landing_home_index_path
#   end

#   private

#   def is_admin?
#     if user_signed_in?
#       if current_user.admin?
#         true
#       else
#         redirect_to root_path
#       end
#     else
#       redirect_to root_path
#     end
#   end
# end