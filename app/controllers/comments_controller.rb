class CommentsController < ApplicationController
  def create
    @service_request = ServiceRequest.find(params[:service_request_id])
    @comment = Comment.create(comment_params)
    Comment.update(@comment,
      user: current_user,
      service_request: @service_request
    )
    
    auto_change_to_process_if_state_is_initial
    message_translate(@comment.body)

    if current_user.admin?
      redirect_to admin_service_request_path(@service_request)
    elsif current_user.customer?
      redirect_to customer_service_request_path(@service_request)
    else
      redirect_to staff_service_request_path(@service_request)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, 
      comment_documents_attributes: [:id, :file_path, :_destroy]
    )
  end

  def auto_change_to_process_if_state_is_initial
    @service_request.process! if @service_request.initial?
  end

  def message_translate(origin_msg)
    if EasyTranslate.detect(origin_msg) == 'zh-CN' || EasyTranslate.detect(origin_msg) == 'zh-TW'
      @comment.update_column(:translated_body, EasyTranslate.translate(origin_msg, to: 'en'))
    else
      @comment.update_column(:translated_body, EasyTranslate.translate(origin_msg, to: 'zh-TW'))
    end
  end
end