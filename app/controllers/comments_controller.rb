class CommentsController < ApplicationController
  def create
    @service_request = ServiceRequest.find(params[:service_request_id])
    @comment = Comment.create(comment_params)
    Comment.update(@comment,
      user: current_user,
      service_request: @service_request
    )
    
    auto_change_to_process_if_state_is_initial
    message_translate(@comment.body, @service_request.used_lang)

    if current_user.customer?
      redirect_to customer_service_request_path(@service_request)
    elsif current_user.admin?
      AssignmentNotifyMailer.reply_notify_customer(@service_request.customer, @service_request).deliver_now
      redirect_to admin_service_request_path(@service_request)
    else
      AssignmentNotifyMailer.reply_notify_customer(@service_request.customer, @service_request).deliver_now
      redirect_to staff_service_request_path(@service_request)
    end
    @service_request.customer.responsibles.each do |responsible|
      # comment createor will not receive the notify mail.
      if responsible != current_user
        AssignmentNotifyMailer.reply_notify_staff(responsible, @service_request).deliver_now
      end
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

  def message_translate(origin_msg, used_lang)
    if EasyTranslate.detect(origin_msg) == used_lang
      @comment.update_column(:translated_body, EasyTranslate.translate(origin_msg, to: 'zh-TW'))
    else
      @comment.update_column(:translated_body, EasyTranslate.translate(origin_msg, to: used_lang))
    end
  end
end