class Merchant < ApplicationRecord
  include AASM

  validates :email, presence: true, uniqueness: true
  validates :status, presence: true

  has_many :transactions, dependent: :destroy

  aasm(:status) do
    state :active, initial: true
    state :inactive

    event :activate do
      transitions from: :inactive, to: :active
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end
  end
end
