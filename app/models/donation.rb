class Donation < ApplicationRecord  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_id, presence: true
end