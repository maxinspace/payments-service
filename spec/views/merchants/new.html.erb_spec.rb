require 'rails_helper'

RSpec.describe "merchants/new", type: :view do
  before(:each) do
    assign(:merchant, Merchant.new(
      name: "MyString",
      description: "MyString",
      email: "MyString",
      status: "MyString",
      total_transaction_sum: "9.99"
    ))
  end

  it "renders new merchant form" do
    render

    assert_select "form[action=?][method=?]", merchants_path, "post" do

      assert_select "input[name=?]", "merchant[name]"

      assert_select "input[name=?]", "merchant[description]"

      assert_select "input[name=?]", "merchant[email]"

      assert_select "input[name=?]", "merchant[status]"

      assert_select "input[name=?]", "merchant[total_transaction_sum]"
    end
  end
end
