class Merchant < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
