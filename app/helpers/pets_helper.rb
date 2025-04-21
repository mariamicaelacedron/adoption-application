module PetsHelper
  def pet_status_badge(pet_or_status)
    if pet_or_status.respond_to?(:adopted?)
      pet = pet_or_status
      if pet.adopted?
        ['info', 'Adoptada']
      elsif pet.status == 'pending_adoption'
        ['warning', 'Pendiente']
      else
        ['success', 'Disponible']
      end
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
    return 'No especificado' unless pet.pet_type.present?
    
    if pet.pet_type.is_a?(String) || pet.pet_type.is_a?(Symbol)
      type_key = pet.pet_type.to_s
      return I18n.t("enums.pet.pet_type.#{type_key}", default: type_key.titleize)
    end
    
    case pet.pet_type
    when 0, 'dog' then I18n.t("enums.pet.pet_type.dog", default: 'Perro')
    when 1, 'cat' then I18n.t("enums.pet.pet_type.cat", default: 'Gato')
    when 2, 'guinea_pig' then I18n.t("enums.pet.pet_type.guinea_pig", default: 'Cobaya')
    when 3, 'other' then I18n.t("enums.pet.pet_type.other", default: 'Otro')
    else 'No especificado'
    end
  end
end