class Admin::ServiceRequestsController < AdminController
  before_action :set_service_request, only: [:show, :change_state]

  def index
    @service_requests = ServiceRequest.all
  end

  def show
  end

  def change_state
    @service_request.update_column(:state, params[:target_state])
    render :show

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
