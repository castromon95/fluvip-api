class Profile < ApplicationRecord
  belongs_to :user

  validates :name,
            presence: { message: 'El nombre es obligatorio' },
            length: { in: 3..30, message: 'El nombre debe tener entre 3 y 30 caracteres' }
  validates :last_name,
            presence: { message: 'El apellido es obligatorio' },
            length: { in: 3..30, message: 'El apellido debe tener entre 3 y 30 caracteres' }
  validates :phone,
            presence: { message: 'El telefono es obligatorio' },
            length: { in: 7..20, message: 'El telefono debe tener entre 7 y 20 caracteres' }
end
