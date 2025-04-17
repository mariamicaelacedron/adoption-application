class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending
  validates :full_name, :phone, :email, :reason, presence: true
end