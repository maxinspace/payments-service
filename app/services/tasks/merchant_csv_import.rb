require 'csv'

class Tasks::MerchantCsvImport
  BATCH_SIZE = 1000
  COLUMN_SEPARATOR = ';'.freeze

  attr_reader :csv
  def initialize(csv)
    @csv = csv
  end

  def call
    CSV.foreach(csv, col_sep: COLUMN_SEPARATOR, headers: true).lazy.each_slice(BATCH_SIZE) do |rows|
      Merchant.upsert_all(rows_serializer(rows), unique_by: :email, record_timestamps: true)
    end
  end

  private

  # could be updated if payload changes
  def rows_serializer(rows)
    rows.map do |row|
      {}.tap do |hash|
        hash['name'] = row['name']
        hash['description'] = row['description']
        hash['email'] = row['email']
        hash['status'] = row['status']
        hash['total_transaction_sum'] = row['total_transaction_sum']
      end
    end
  end
end
