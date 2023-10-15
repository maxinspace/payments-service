class Transactions::Jobs::PurgeStaleTransactions
  def self.call
    new.call
  end

  def call
    Transaction.transaction do
      Transaction.where('created_at < ?', 1.hour.ago).destroy_all
    end
  end
end