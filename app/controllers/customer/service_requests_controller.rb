class Customer::ServiceRequestsController < CustomersController
  before_action :set_service_request, only: [:show, :edit, :update, :destroy]

  def index
    @service_requests = ServiceRequest.where(customer: current_user)
  end

  def show
    @comments = @service_request.comments.order('created_at DESC')
  end

  def new
    @service_request = ServiceRequest.new
    @service_request.images.build
    @service_request.attachments.build
  end

  def edit
    
  end

  def create
    @service_request = ServiceRequest.new(service_request_params)

    respond_to do |format|
      if @service_request.valid?
        @service_request.customer = current_user
        @service_request.deadline = Date.strptime(service_request_params[:deadline], '%m/%d/%Y')
        translate = @service_request.description.to_traditional_chinese
        @service_request.translated_desc = translate
        @service_request.save
        format.html { redirect_to customer_root_path, notice: 'Service request was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @service_request.update(service_request_params)
        translate = @service_request.description.to_traditional_chinese
        @service_request.translated_desc = translate
        @service_request.save
        format.html { redirect_to customer_root_path, notice: 'Service request was successfully created.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @service_request.destroy
    respond_to do |format|
      format.html { redirect_to service_requests_url, notice: 'Service request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
      params.require(:service_request).permit(:title, :category_id, :description, :deadline,
        images_attributes: [:id, :file_path, :_destroy], 
        attachments_attributes: [:id, :file_path, :_destroy]
      )
    end
end
