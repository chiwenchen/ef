require 'rails_helper'

RSpec.describe "service_requests/show", type: :view do
  before(:each) do
    @service_request = assign(:service_request, ServiceRequest.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
