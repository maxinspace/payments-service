class Transactions::Api::Update
  def self.call(params:, user:)
    new(params: params, user: user).call
  end

  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    transaction = Transaction.find(@params[:id])

    case @params[:action]
    when 'charge' then transaction.charge!
    when 'reverse' then transaction.reverse!
    when 'refund' then transaction.refund!
    when 'error' then transaction.error!
    when 'reset' then transaction.reset!
    else
      raise StandardError, 'Invalid action'
    end
  end
end