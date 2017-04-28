require 'rails_helper'

RSpec.describe "service_requests/index", type: :view do
  before(:each) do
    assign(:service_requests, [
      ServiceRequest.create!(),
      ServiceRequest.create!()
    ])
  end

  it "renders a list of service_requests" do
    render
  end
end
