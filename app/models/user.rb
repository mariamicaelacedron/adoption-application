class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adoption_applications, dependent: :destroy
  has_many :pets, through: :adoption_applications
  has_many :donations, dependent: :destroy
  
  enum :role, [:user, :admin], default: :user
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }  
end