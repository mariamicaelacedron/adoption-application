class Donation < ApplicationRecord
  belongs_to :user
  has_one_attached :payment_proof 
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum :donation_type, {dinero: 'dinero', alimento: 'alimento', medicinas: 'medicinas', otros: 'otros'}, default: 'dinero'

  enum :status, {
    pendiente: 'pendiente',
    completado: 'completado',
    cancelado: 'cancelado'
  }, default: 'pendiente'

  validates :donation_type, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true

  validates :payment_proof, 
            content_type: ['image/png', 'image/jpeg', 'application/pdf'],
            size: { less_than: 5.megabytes }
end