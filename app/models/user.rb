class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :adoptions, dependent: :destroy
  has_many :pets, through: :adoptions
  has_many :donations, dependent: :destroy
  
  enum :role, [:user, :admin], default: :user
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }  
end