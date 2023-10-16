require 'rails_helper'

describe Transactions::Aasm::HandleCharged do
  describe '.call' do
    subject(:handle_charged) { described_class.call(transaction) }

    let(:transaction) { create(:transaction, :charged) }

    it 'charges the transaction' do
      handle_charged

      expect(Transactions::Charged.find(transaction.id)).to be_present
    end

    it 'updates the merchant total_transaction_sum' do
      expect { handle_charged }.to change { transaction.merchant.reload.total_transaction_sum }.by(transaction.amount)
    end
  end
end