module PetsHelper
  def default_pet_image_url(pet_type, size: '400x300')
    default_images = {
      dog: 'default/default_dog.jpg',
      cat: 'default/default_cat.jpg',
      other: 'default/default_pet.jpg'
    }
    
    image_path = default_images[pet_type.to_sym] || default_images[:other]
    
    if asset_exists?(image_path)
      asset_path(image_path)
    else
      # Fallback (opcional)
      "https://placedog.net/400/300?random=#{rand(1000)}"
    end
  end
  
  private
  
  def asset_exists?(path)
    Rails.application.assets&.find_asset(path).present?
  rescue
    false
  end
end