class Transactions::Aasm::HandleCharged
  def self.call(transaction)
    new(transaction).call
  end

  attr_reader :transaction
  def initialize(transaction)
    @transaction = transaction
  end

  def call
    Merchant.transaction do
      transaction.update_columns(type: Constants::Transaction::STATUS_TYPE_MAPPER[transaction.status])

      merchant.update!(total_transaction_sum: merchant.total_transaction_sum + transaction.amount)
    end
  end

  private

  def merchant
    Merchant.lock("FOR UPDATE NOWAIT").find(transaction.merchant_id)
  end
end