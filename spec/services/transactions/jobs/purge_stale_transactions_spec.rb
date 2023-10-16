require 'rails_helper'

describe Transactions::Jobs::PurgeStaleTransactions do
  describe '.call' do
    let!(:transaction) { create(:transaction, created_at: 2.hours.ago) }

    it 'purges stale transactions' do
      expect { described_class.call }.to change { Transaction.count }.by(-1)
      expect(Transaction.where(id: transaction.id)).not_to exist
    end
  end
end