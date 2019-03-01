class Pet < ApplicationRecord
  belongs_to :user

  validates :species,
            presence: { message: 'La especie es obligatoria' },
            length: { in: 3..30, message: 'La especie debe tener entre 3 y 30 caracteres' }
  validates :breed,
            length: { in: 3..30, message: 'La raza debe tener entre 3 y 20 caracteres' },
            allow_blank: true
  validates :name,
            presence: { message: 'El nombre es obligatorio' },
            length: { in: 3..30, message: 'El nombre debe tener entre 3 y 30 caracteres' }
  validates :food,
            presence: { message: 'El tipo de comida es obligatorio' },
            length: { in: 3..30, message: 'El tipo de comida debe tener entre 3 y 30 caracteres' }
  validates :diseases,
            length: { in: 10..200, message: 'Las enfermedades y alergias deben tener entre 10 y 200 caracteres' },
            allow_blank: true
  validates :care,
            length: { in: 10..200, message: 'Los cuidados especiales deben tener entre 10 y 200 caracteres' },
            allow_blank: true



end
