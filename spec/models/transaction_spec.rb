require 'rails_helper'

describe Transaction do
  let(:merchant) { create(:merchant) }
  let(:transaction) { create(:transaction, merchant: merchant) }

  describe '.validations' do
    it 'has a valid factory' do
      expect(transaction).to be_valid
    end

    it 'is invalid without an amount' do
      transaction.amount = nil
      expect(transaction).to be_invalid
    end

    it 'is invalid without a status' do
      transaction.status = nil
      expect(transaction).to be_invalid
    end

    it 'is invalid without a type' do
      transaction.type = nil
      expect(transaction).to be_invalid
    end

    it 'is invalid with a negative amount' do
      transaction.amount = -1
      expect(transaction).to be_invalid
    end
  end

  describe '.transitions' do
    before do
      allow(Transactions::Aasm::HandleCharged).to receive(:call).with(transaction).and_return(true)
      allow(Transactions::Aasm::HandleReversed).to receive(:call).with(transaction).and_return(true)
      allow(Transactions::Aasm::HandleRefunded).to receive(:call).with(transaction).and_return(true)
      allow(Transactions::Aasm::HandleError).to receive(:call).with(transaction).and_return(true)
      allow(Transactions::Aasm::HandleReset).to receive(:call).with(transaction).and_return(true)
    end

    describe '#charge' do
      let(:transaction) { create(:transaction, :authorized, merchant: merchant) }
      it 'transitions from authorized to charged' do
        transaction.charge!
        expect(transaction).to be_charged
        expect(Transactions::Aasm::HandleCharged).to have_received(:call).with(transaction)
      end
    end

    describe '#reverse' do
      let(:transaction) { create(:transaction, :authorized, merchant: merchant) }
      it 'transitions from authorized to reversed' do
        transaction.reverse!
        expect(transaction).to be_reversed
        expect(Transactions::Aasm::HandleReversed).to have_received(:call).with(transaction)
      end
    end

    describe '#refund' do
      let(:transaction) { create(:transaction, :charged, merchant: merchant) }
      it 'transitions from charged to refunded' do
        transaction.refund!
        expect(transaction).to be_refunded
        expect(Transactions::Aasm::HandleRefunded).to have_received(:call).with(transaction)
      end
    end

    describe '#error' do
      let(:transaction) { create(:transaction, :authorized, merchant: merchant) }
      it 'transitions from authorized to error' do
        transaction.error!
        expect(transaction).to be_error
        expect(Transactions::Aasm::HandleError).to have_received(:call).with(transaction)
      end
    end
  end
end
