class CommentsController < ApplicationController
  def create
    @service_request = ServiceRequest.find(params[:service_request_id])
    @comment = Comment.create(comment_params)
    Comment.update(@comment,
      user: current_user,
      service_request: @service_request
    )
    if current_user.admin?
      redirect_to admin_service_request_path(@service_request)
    elsif current_user.customer?
      redirect_to customer_service_request_path(@service_request)
    else
      # redirect to staff service request path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end