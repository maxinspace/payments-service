class Constants::Transaction
  STATUS_TYPE_MAPPER = {
    'authorized' => 'Transactions::Authorized',
    'charged' => 'Transactions::Charged',
    'reversed' => 'Transactions::Reversed',
    'refunded' => 'Transactions::Refunded',
    'error' => 'Transactions::Error'
  }.freeze
end