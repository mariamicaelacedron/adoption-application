# Crear admin
User.create!(
  email: 'admin@salvandopatitas.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Admin',
  last_name: 'Salvando Patitas',
  role: :admin
)

# Crear usuario normal
User.create!(
  email: 'usuario@ejemplo.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Juan',
  last_name: 'Pérez'
)

# Crear algunas mascotas
Pet.create!([
  { name: 'Firulais', breed: 'Labrador', age: 2, pet_type: :dog, description: 'Perro juguetón y cariñoso' },
  { name: 'Michi', breed: 'Siamés', age: 1, pet_type: :cat, description: 'Gato tranquilo y curioso' },
  { name: 'Pelusa', breed: 'Abisinio', age: 3, pet_type: :guinea_pig, description: 'Cobaya muy sociable' }
])