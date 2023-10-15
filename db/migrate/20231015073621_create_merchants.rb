class CreateMerchants < ActiveRecord::Migration[7.1]
  def up
    create_enum :merchant_status, %i[active inactive]

    create_table :merchants do |t|
      t.string :name
      t.string :description
      t.string :email, null: false, index: { unique: true }
      t.enum :status, enum_type: :merchant_status, default: :active, null: false
      t.decimal :total_transaction_sum, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end

  def down
    drop_table :merchants
    drop_enum :merchant_status
  end
end
