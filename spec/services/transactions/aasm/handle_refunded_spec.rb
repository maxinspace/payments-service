require 'rails_helper'

describe Transactions::Aasm::HandleRefunded do
  describe '.call' do
    subject(:handle_refunded) { described_class.call(transaction) }

    let(:transaction) { create(:transaction, :refunded) }

    it 'refunds the transaction' do
      handle_refunded

      expect(Transactions::Refunded.find(transaction.id)).to be_present
    end

    it 'updates the merchant total_transaction_sum' do
      expect { handle_refunded }.to change { transaction.merchant.reload.total_transaction_sum }.by(-transaction.amount)
    end
  end
end