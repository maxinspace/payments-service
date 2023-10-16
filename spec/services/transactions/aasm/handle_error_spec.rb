require 'rails_helper'

describe Transactions::Aasm::HandleError do
  describe '.call' do
    subject(:handle_error) { described_class.call(transaction) }

    let(:transaction) { create(:transaction, :error) }

    it 'errors the transaction' do
      expect { handle_error }.to change { Transactions::Error.count }.by(1)
    end
  end
end