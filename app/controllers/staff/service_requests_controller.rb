class Staff::ServiceRequestsController < StaffsController
  before_action :set_service_request, only: [:show, :change_state]

  def index
    @service_requests = current_user.assigned_service_requests.order('created_at DESC')
    # change to staff belongs only
  end

  def show
    @comments = @service_request.comments.order('created_at DESC')
    @comment = Comment.new
    @comment.comment_documents.build
  end

  def change_state
    @service_request.send("#{params[:aasm_event]}!")
    redirect_to staff_service_request_path(@service_request)
  end

  private

    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end


    def service_request_params
      params.require(:service_request).permit(:title, :category_id, :description, :deadline, 
        images_attributes: [:id, :file, :_destroy], 
        attachments_attributes: [:id, :file, :_destroy]
      )
    end
end
