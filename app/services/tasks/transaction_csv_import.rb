require 'csv'

class Tasks::TransactionCsvImport
  BATCH_SIZE = 1000
  COLUMN_SEPARATOR = ';'.freeze

  attr_reader :csv
  def initialize(csv)
    @csv = csv
  end

  def call
    CSV.foreach(csv, col_sep: COLUMN_SEPARATOR, headers: true).lazy.each_slice(BATCH_SIZE) do |rows|
      Transaction.upsert_all(rows_serializer(rows), unique_by: :uuid, record_timestamps: true)
    end
  end

  private

  # We import transactions with authorized type only, otherwise it would require handling every transaction separately
  def rows_serializer(rows)
    rows.map do |row|
      {}.tap do |hash|
        hash['uuid'] = row['uuid']
        hash['amount'] = row['amount']
        hash['customer_email'] = row['customer_email']
        hash['customer_phone'] = row['customer_phone']
        hash['merchant_id'] = row['merchant_id']
      end
    end
  end
end