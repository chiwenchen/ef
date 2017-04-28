require 'rails_helper'

RSpec.describe "service_requests/new", type: :view do
  before(:each) do
    assign(:service_request, ServiceRequest.new())
  end

  it "renders new service_request form" do
    render

    assert_select "form[action=?][method=?]", service_requests_path, "post" do
    end
  end
end
