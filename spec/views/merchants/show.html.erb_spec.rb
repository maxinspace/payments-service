require 'rails_helper'

RSpec.describe "merchants/show", type: :view do
  before(:each) do
    assign(:merchant, Merchant.create!(
      name: "Name",
      description: "Description",
      email: "Email",
      status: "Status",
      total_transaction_sum: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
  end
end
