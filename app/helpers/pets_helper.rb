module PetsHelper
  def pet_image_url(pet, size: '300x200')
    if pet.image.attached?
      pet.image.variant(resize_to_fill: size.split('x').map(&:to_i))
    else
      default_pet_image_url(pet.pet_type, size: size)
    end
  end

  def default_pet_image_url(pet_type, size: '300x200')
    width, height = size.split('x')
    case pet_type.to_sym
    when :dog then "https://placedog.net/#{width}/#{height}?random=#{rand(1000)}"
    when :cat then "https://placekitten.com/#{width}/#{height}?random=#{rand(1000)}"
    when :guinea_pig then "https://loremflickr.com/#{width}/#{height}/guineapig?random=#{rand(1000)}"
    else "https://loremflickr.com/#{width}/#{height}/animal?random=#{rand(1000)}"
    end
  end
end