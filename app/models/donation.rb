class Donation < ApplicationRecord
  belongs_to :user
  has_one_attached :payment_proof 
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum :donation_type, { money: 'money', food: 'food', medicine: 'medicine', other: 'other' }, default: 'money'
  enum :status, { pending: 'pending', completed: 'completed', canceled: 'canceled' }, default: 'pending'
  enum :payment_method, { bank_transfer: 'bank_transfer', mercado_pago: 'mercado_pago', cash: 'cash' }, default: 'bank_transfer'
  
  validates :donation_type, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true

  validates :payment_proof, 
            presence: { unless: -> { payment_method == 'mercado_pago' } },
            content_type: ['image/png', 'image/jpeg', 'application/pdf'],
            size: { less_than: 5.megabytes },
            if: -> { payment_proof.attached? }
end
