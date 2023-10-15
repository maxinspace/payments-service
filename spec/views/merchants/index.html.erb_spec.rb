require 'rails_helper'

RSpec.describe "merchants/index", type: :view do
  before(:each) do
    assign(:merchants, [
      Merchant.create!(
        name: "Name",
        description: "Description",
        email: "Email",
        status: "Status",
        total_transaction_sum: "9.99"
      ),
      Merchant.create!(
        name: "Name",
        description: "Description",
        email: "Email",
        status: "Status",
        total_transaction_sum: "9.99"
      )
    ])
  end

  it "renders a list of merchants" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
  end
end
