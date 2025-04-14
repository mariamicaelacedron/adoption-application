class AdoptionApplication < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  enum status: [:pending, :approved, :rejected], default: :pending

  validates :application_text, presence: true
end