require 'rails_helper'

describe Merchant do
  let(:merchant) { create(:merchant) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(merchant).to be_valid
    end

    it 'is invalid without an email' do
      merchant.email = nil
      expect(merchant).to be_invalid
    end

    it 'is invalid without a status' do
      merchant.status = nil
      expect(merchant).to be_invalid
    end

    it 'is invalid with a duplicate email' do
      another_merchant = build(:merchant, email: merchant.email)
      expect(another_merchant).to be_invalid
    end
  end
end
