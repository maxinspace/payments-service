require 'rails_helper'

describe Transactions::Api::Update do
  describe '.call' do
    subject(:update) { described_class.call(params: params, user: nil) }

    let(:params) do
      {
        id: transaction.id,
        action: action
      }
    end

    context 'when action is charge' do
      let!(:transaction) { create(:transaction, :authorized) }
      let(:action) { 'charge' }

      it 'charges the transaction' do
        expect { update }.to change { Transactions::Charged.count }.by(1)
      end
    end

    context 'when action is reverse' do
      let!(:transaction) { create(:transaction, :authorized) }
      let(:action) { 'reverse' }

      it 'reverses the transaction' do
        expect { update }.to change { Transactions::Reversed.count }.by(1)
      end
    end

    context 'when action is refund' do
      let!(:transaction) { create(:transaction, :charged) }
      let(:action) { 'refund' }

      it 'refunds the transaction' do
        expect { update }.to change { Transactions::Refunded.count }.by(1)
      end
    end

    context 'when action is error' do
      let!(:transaction) { create(:transaction, :authorized) }
      let(:action) { 'error' }

      it 'errors the transaction' do
        expect { update }.to change { Transactions::Error.count }.by(1)
      end
    end

    context 'when action is invalid' do
      let!(:transaction) { create(:transaction, :authorized) }
      let(:action) { 'invalid' }

      it 'raises an error' do
        expect { update }.to raise_error(StandardError, 'Invalid action')
      end
    end
  end
end