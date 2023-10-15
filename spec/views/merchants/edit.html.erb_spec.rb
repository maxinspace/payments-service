require 'rails_helper'

RSpec.describe "merchants/edit", type: :view do
  let(:merchant) {
    Merchant.create!(
      name: "MyString",
      description: "MyString",
      email: "MyString",
      status: "MyString",
      total_transaction_sum: "9.99"
    )
  }

  before(:each) do
    assign(:merchant, merchant)
  end

  it "renders the edit merchant form" do
    render

    assert_select "form[action=?][method=?]", merchant_path(merchant), "post" do

      assert_select "input[name=?]", "merchant[name]"

      assert_select "input[name=?]", "merchant[description]"

      assert_select "input[name=?]", "merchant[email]"

      assert_select "input[name=?]", "merchant[status]"

      assert_select "input[name=?]", "merchant[total_transaction_sum]"
    end
  end
end
