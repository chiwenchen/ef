require 'rails_helper'

RSpec.describe "service_requests/edit", type: :view do
  before(:each) do
    @service_request = assign(:service_request, ServiceRequest.create!())
  end

  it "renders the edit service_request form" do
    render

    assert_select "form[action=?][method=?]", service_request_path(@service_request), "post" do
    end
  end
end
