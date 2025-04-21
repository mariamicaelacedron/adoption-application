class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending
  validates :full_name, :phone, :email, :reason, presence: true
  validates :user_id, uniqueness: { scope: :pet_id, message: "ya tiene una solicitud para esta mascota" }
  after_update :notify_status_change, if: :saved_change_to_status?
  after_update :update_pet_status, if: :saved_change_to_status?

  private

  def notify_status_change
    case status
    when 'approved'
      UserMailer.adoption_approved(self).deliver_later
    when 'rejected'
      UserMailer.adoption_rejected(self).deliver_later
    end
  end

  def update_pet_status
    if approved?
      pet.update!(status: :adopted)
    elsif rejected? && pet.adoptions.approved.none?
      pet.update!(status: :available)
    end
  end
end