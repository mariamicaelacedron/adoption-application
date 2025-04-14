class Pet < ApplicationRecord
  has_many :adoption_applications, dependent: :destroy
  has_many :applicants, through: :adoption_applications, source: :user
  
  enum :pet_type, [:dog, :cat, :guinea_pig, :other], default: :dog
  enum :status, [:available, :pending_adoption, :adopted], default: :available
  
  validates :name, :breed, :age, :pet_type, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }
  
  has_one_attached :image
end