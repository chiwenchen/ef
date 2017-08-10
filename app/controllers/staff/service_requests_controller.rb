class Staff::ServiceRequestsController < StaffsController
  before_action :set_service_request, only: [:show, :change_state]

  def index
    # @q = current_user.assigned_service_requests.search(params[:q])
    # has_search_term = false
    # params[:q].each do |k,v|
    #   has_search_term = true if v != ''
    # end
    if has_search_term
      @service_requests = @q.result.order('created_at DESC')
    # change to staff belongs only
    elsif current_user.sales?
      @service_requests_mainly_response = ServiceRequest.joins(:customer).where(users: {owner_id: current_user.id}).order('created_at DESC')
      @service_requests = ServiceRequest.joins(:customer).where(users: {sales_id: current_user.id}).order('created_at DESC')
    elsif current_user.tech?
      @service_requests = ServiceRequest.joins(:customer).where(users: {tech_id: current_user.id}).order('created_at DESC')
    end
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
