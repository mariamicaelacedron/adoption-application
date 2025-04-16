class Pet < ApplicationRecord
  has_one_attached :image

  enum :pet_type, {
    dog: 0,
    cat: 1,
    guinea_pig: 2,
    other: 3
  }

  enum :status, {
    available: 0,
    pending_adoption: 1,
    adopted: 2
  }

  validates :name, :breed, :age, :pet_type, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where(status: :available) }
  scope :by_type, ->(type) { where(pet_type: type) }
  validate :acceptable_image

  private

  def acceptable_image
    return unless image.attached?

    unless image.blob.byte_size <= 5.megabyte
      errors.add(:image, "es demasiado grande (máximo 5MB)")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.blob.content_type)
      errors.add(:image, "debe ser JPEG o PNG")
    end
  end
end