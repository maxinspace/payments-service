# DEBUGGING THING
class Transactions::Aasm::HandleReset
  def self.call(transaction)
    new(transaction).call
  end

  attr_reader :transaction
  def initialize(transaction)
    @transaction = transaction
  end

  def call
    Transaction.transaction do
      transaction.update_columns(type: Constants::Transaction::STATUS_TYPE_MAPPER[transaction.status])
    end
  end
end