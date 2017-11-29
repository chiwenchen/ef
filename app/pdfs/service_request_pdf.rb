class ServiceRequestPdf < Prawn::Document
  def initialize(service_request_ids)
    super(top_margin: 30, page_layout: :landscape)
    @service_request_ids = service_request_ids
    table_object = [
      ['Customer Name', 'Equipment ID', 'Title', 'Deadline', 'State', 'Owner', 'Sales', 'Tech']
    ]
    @service_request_ids.each do |id|
      sr = ServiceRequest.find(id)
      customer = sr.customer
      owner = (customer.owner.username if customer.owner) || '-'
      sales = (customer.sales.username if customer.sales) || '-'
      tech = (customer.tech.username if customer.tech) || '-'
      table_object << [customer.username, sr.equipment_id, sr.title, sr.deadline, sr.state, owner, sales, tech]
    end
    font_families.update("zhonly" => {
      :normal => Rails.root.join("app/assets/fonts/msjh.ttf")
    })
    font 'zhonly'
    table(table_object, header: true, position: :center)
  end
end