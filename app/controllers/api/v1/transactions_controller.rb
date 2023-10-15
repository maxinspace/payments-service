class Api::V1::TransactionsController < ApplicationController
  # GET api/v1/transactions
  def index
    @transactions = Transaction.all
    render json: @transactions, status: :ok
  end

  # POST api/v1/transactions
  def create
    transaction = Transactions::Api::Create.call(params: params, user: current_user)

    if transaction.valid?
      render json: transaction, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH api/v1/transactions/:id
  def update
    transaction = Transactions::Api::Update.call(params: update_params[:action], user: current_user)

    if transaction.valid?
      render json: transaction, status: :ok
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.permit(:action)
  end
end