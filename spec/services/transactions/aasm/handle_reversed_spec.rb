require 'rails_helper'

describe Transactions::Aasm::HandleReversed do
  describe '.call' do
    subject(:handle_reversed) { described_class.call(transaction) }

    let(:transaction) { create(:transaction, :reversed) }

    it 'reverses the transaction' do
      handle_reversed

      expect(Transactions::Reversed.find(transaction.id)).to be_present
    end
  end
end