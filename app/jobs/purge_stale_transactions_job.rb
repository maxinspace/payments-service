# frozen_string_literal: true

class PurgeStaleTransactionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Transactions::Jobs::PurgeStaleTransactions.new.call
  end
end