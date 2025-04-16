module PetsHelper
  def pet_status_badge(status)
    # Convierte a string y luego a símbolo, con valor por defecto
    status_key = status.to_s.presence || 'pending'
    
    case status_key.to_sym
    when :available then 'success'
    when :adopted then 'secondary'
    when :pending then 'warning'
    else 'info'
    end
  end
  def display_pet_type(pet)
    case pet.pet_type
    when 0 then 'Perro'
    when 1 then 'Gato'
    when 2 then 'Cobaya'
    when 3 then 'Otro'
    else 'No especificado'
    end
  end
end