class Staff::ServiceRequestsController < StaffsController
  before_action :set_service_request, only: [:show, :change_state]

  def index
    if current_user.sales?
      request_index_for_sales
    elsif current_user.tech?
      request_index_for_tech
    end
  end

  def owned_index
    request_index_for_owner
  end

  def show
    @comments = @service_request.comments.order('created_at DESC')
    @comment = Comment.new
    @comment.comment_documents.build
  end

  def change_state
    @service_request.send("#{params[:aasm_event]}!")
    @service_request.customer.responsibles.each do |recipient|
      AssignmentNotifyMailer.notify_staff_state_change(recipient, @service_request).deliver_now
    end
    AssignmentNotifyMailer.notify_customer_state_change(@service_request.customer, @service_request).deliver_now

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

    def request_index_for_owner
      @q = ServiceRequest.joins(:customer).where(users: {owner_id: current_user.id}).search(params[:q])
      has_search_term_for_main = false
      params[:q].each { |k,v| has_search_term_for_main = true if v != '' } if params[:q]
      if @q and has_search_term_for_main
        @service_requests_mainly_response = @q.result.order('created_at DESC').page(params[:page]).per(10)
      else
        @service_requests_mainly_response = ServiceRequest.joins(:customer).where(users: {owner_id: current_user.id}).order('created_at DESC').page(params[:page]).per(10)
      end
    end

    def request_index_for_sales
      @q = ServiceRequest.joins(:customer).where(users: {sales_id: current_user.id}).search(params[:q])
      has_search_term = false
      params[:q].each { |k,v| has_search_term = true if v != '' } if params[:q]
      if @q and has_search_term
        @service_requests = @q.result.order('created_at DESC').page(params[:page]).per(10)
      else
        @service_requests = ServiceRequest.joins(:customer).where(users: {sales_id: current_user.id}).order('created_at DESC').page(params[:page]).per(10)
      end
    end
    def request_index_for_tech
      @q = ServiceRequest.joins(:customer).where(users: {sales_id: current_user.id}).search(params[:q])
      has_search_term = false
      params[:q].each { |k,v| has_search_term = true if v != '' } if params[:q]
      if @q and has_search_term
        @service_requests = @q.result.order('created_at DESC').page(params[:page]).per(10)
      else
        @service_requests = ServiceRequest.joins(:customer).where(users: {tech_id: current_user.id}).order('created_at DESC').page(params[:page]).per(10)
      end
    end
end
