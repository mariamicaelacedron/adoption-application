module PetsHelper
  def pet_status_badge(pet_or_status)
    # Si recibe un objeto Pet completo
    if pet_or_status.respond_to?(:adopted?)
      pet = pet_or_status
      if pet.adopted?
        ['info', 'Adoptada']
      elsif pet.status == 'pending_adoption'
        ['warning', 'Pendiente']
      else
        ['success', 'Disponible']
      end
    # Si recibe solo el status (para compatibilidad con código existente)
    else
      status = pet_or_status.to_s
      case status
      when 'available' then ['success', 'Disponible']
      when 'pending_adoption' then ['warning', 'Pendiente']
      when 'adopted' then ['info', 'Adoptada']
      else ['secondary', 'No especificado']
      end
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