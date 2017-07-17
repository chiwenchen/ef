class ServiceRequestPdf < Prawn::Document
  def initialize(service_request_ids)
    super(top_margin: 30, page_layout: :landscape)
    @service_request_ids = service_request_ids
    table_object = [
      [I18n.t('service_request.customer_name'), 'Equipment ID', 'Title']
    ]
    10.times do
      @service_request_ids.each do |id|
        sr = ServiceRequest.find(id)
        table_object << [sr.customer.username, sr.equipment_id, sr.title]
      end
    end
    # font_families.update("zhonly" => {
    #   :normal => Rails.root.join("app/assets/fonts/cwTeXKai-zhonly.ttf")
    # })
    # font 'zhonly'
    table(table_object, header: true, position: :center)
  end
end