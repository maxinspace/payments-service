class Transactions::Api::Create
  def self.call(params:, user:)
    new(params: params, user: user).call
  end

  attr_reader :params, :user
  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    transaction = Transaction.new(params)

    validate_merchant(transaction)

    transaction.save unless transaction.errors.any?

    transaction
  end

  private

  def validate_merchant(transaction)
    return if transaction.merchant.active?

    transaction.errors.add(:merchant, "is inactive")
  end
end