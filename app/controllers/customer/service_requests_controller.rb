class Customer::ServiceRequestsController < CustomersController
  before_action :set_service_request, only: [:show, :edit, :update, :destroy, :change_state]

  def index
    @q = ServiceRequest.where(customer: current_user).search(params[:q])
    @service_requests = @q.result.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
    @comments = @service_request.comments.order('created_at DESC')
    @comment = Comment.new
    @comment.comment_documents.build
  end

  def new
    @service_request = ServiceRequest.new
    @service_request.images.build
    @service_request.attachments.build
  end

  def edit; end

  def create
    @service_request = ServiceRequest.new(service_request_params)

    if @service_request.valid?
      @service_request.customer = current_user
      @service_request.used_lang = EasyTranslate.detect @service_request.description
      if @service_request.used_lang != 'zh-TW'
        translate = @service_request.description.to_traditional_chinese
      else
        translate = @service_request.description.to_english
      end

      @service_request.translated_desc = translate
      @service_request.deadline = Date.today + 7.days
      @service_request.save

      AssignmentNotifyMailer.notify_customer(current_user, @service_request).deliver_now
      current_user.responsibles.each do |responsible|
        AssignmentNotifyMailer.notify_staff(responsible, @service_request).deliver_now
        LineService.send(
          responsible.line_user_id,
          "客戶 #{current_user.username} 已新增一筆客訴單，單號：#{@service_request.request_id}，請前往系統處理。"
        )
      end
      flash[:notice] = I18n.t('service_request.created')
      redirect_to customer_root_path
    else
      flash[:error] = I18n.t('service_request.creation_fail')
      render :new
    end
  end

  def update
    respond_to do |format|
      if @service_request.update(service_request_params)
        translate = @service_request.description.to_traditional_chinese
        @service_request.translated_desc = translate
        @service_request.save
        current_user.responsibles.each do |responsible|
          LineService.send(responsible.line_user_id, "客戶 #{current_user.username} 已更新一筆客訴單，單號：#{@service_request.request_id}，請前往系統處理。")
        end
        format.html { redirect_to customer_root_path, notice: I18n.t('service_request.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @service_request.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: I18n.t('service_request.destroyed') }
    end
  end

  def change_state
    @service_request.send("#{params[:aasm_event]}!")

    @service_request.customer.responsibles.each do |recipient|
      AssignmentNotifyMailer.notify_staff_state_change(recipient, @service_request).deliver_now
    end
    AssignmentNotifyMailer.notify_customer_state_change(@service_request.customer, @service_request).deliver_now

    redirect_to customer_service_request_path(@service_request)
  end

  private

    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
      params.require(:service_request).permit(:title, :category_id, :description, :equipment_id,
        images_attributes: [:id, :file_path, :_destroy],
        attachments_attributes: [:id, :file_path, :_destroy]
      )
    end
end
