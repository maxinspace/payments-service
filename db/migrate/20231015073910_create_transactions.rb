class CreateTransactions < ActiveRecord::Migration[7.1]
  def up
    enable_extension "uuid-ossp"

    create_enum :transaction_type, %w[Transactions::Authorized Transactions::Charged Transactions::Reversed Transactions::Refunded Transactions::Error]
    create_enum :transaction_status, %i[authorized charged reversed refunded error]

    create_table :transactions do |t|
      t.uuid :uuid, default: -> { "uuid_generate_v4()" }, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.enum :type, enum_type: :transaction_type, default: "Transactions::Authorized", null: false
      t.enum :status, enum_type: :transaction_status, default: :authorized, null: false
      t.string :customer_email
      t.string :customer_phone
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :transactions
    drop_enum :transaction_status
    drop_enum :transaction_type
    disable_extension "uuid-ossp"
  end
end
