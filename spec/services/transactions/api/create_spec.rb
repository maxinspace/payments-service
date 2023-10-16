require 'rails_helper'

describe Transactions::Api::Create do
  describe '.call' do
    subject(:transaction) { described_class.call(params: params, user: nil) }

    let(:merchant) { create(:merchant) }
    let(:params) do
      {
        uuid: SecureRandom.uuid,
        amount: 9.99,
        customer_email: 'foo@mail.com',
        customer_phone: '1234567890',
        status: :authorized,
        merchant_id: merchant.id
      }
    end

    it 'creates a transaction' do
      expect { transaction }.to change { Transaction.count }.by(1)
    end

    context 'when merchant is inactive' do
      let(:merchant) { create(:merchant, status: :inactive) }

      it 'raises an error' do
        expect(transaction.errors[:merchant]).to include('is inactive')
      end
    end
  end
end