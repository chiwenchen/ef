class Admin::ServiceRequestsController < AdminController
  before_action :set_service_request, only: [:show, :change_state]

  def index
    @q = ServiceRequest.search(params[:q])
    if params[:state].present?
      @service_requests = ServiceRequest.where(state: params[:state]).order('created_at DESC')
    elsif params[:q].present?
      @service_requests = @q.result
    else
      @service_requests = ServiceRequest.all.order('created_at DESC')
    end
    respond_to do |format|
      format.html
      if params[:service_request_ids]
        format.pdf do
          pdf = ServiceRequestPdf.new(params[:service_request_ids])
          send_data pdf.render, file_name: "Claim List",
                                type: "application/pdf",
                                disposition: "inline"
        end
      end
    end
  end

  def show
    @comments = @service_request.comments.order('created_at DESC')
    @comment = Comment.new
    @comment.comment_documents.build
  end

  def change_state
    @service_request.send("#{params[:aasm_event]}!")
    redirect_to admin_service_request_path(@service_request)
  end

  def update_assignment
    @service_request = ServiceRequest.find(params[:id])
    @service_request.assignments.destroy_all
    if service_request_params and service_request_params['responsible_ids']
      service_request_params['responsible_ids'].each do |responsible|
        Assignment.create(user_id: responsible, service_request: @service_request)
      end
    end
    @service_request.responsibles.each do |user|
      AssignmentNotifyMailer.notify(user, @service_request).deliver_now
      if user.line_user_id.present?
        text = "您已經被指派一個客訴單，請前往系統查看"
        LineService.send(user.line_user_id, text)
      end
    end
    @service_request.process! if @service_request.initial?
    flash[:notice] = 'Assignment update successfully'
    redirect_to admin_service_request_path(@service_request)
  end

  private

    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
      if params[:service_request].present?
        params.require(:service_request).permit(:title, :category_id, :description, :deadline, 
          images_attributes: [:id, :file, :_destroy], 
          attachments_attributes: [:id, :file, :_destroy]
        )
        params.require(:service_request).tap do |whitelisted|
          whitelisted[:file] = params[:responsible_ids]
        end
      end
    end
end
