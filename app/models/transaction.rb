class Transaction < ApplicationRecord
  include AASM

  self.table_name = 'transactions'

  belongs_to :merchant

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :type, presence: true

  aasm(:status) do
    state :authorized, initial: true
    state :charged
    state :reversed
    state :refunded
    state :error

    event :charge, after_commit: -> { Transactions::Aasm::HandleCharged.call(self) } do
      transitions from: :authorized, to: :charged
    end

    event :reverse, after_commit: -> { Transactions::Aasm::HandleReversed.call(self) } do
      transitions from: :authorized, to: :reversed
    end

    event :refund, after_commit: -> { Transactions::Aasm::HandleRefunded.call(self) } do
      transitions from: :charged, to: :refunded
    end

    event :error, after_commit: -> { Transactions::Aasm::HandleError.call(self) } do
      transitions from: :authorized, to: :error
    end

    event :reset, after_commit: -> { Transactions::Aasm::HandleReset.call(self) } do
      transitions to: :authorized
    end
  end
end
