class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.references :user, foreign_key: true, null: false
      t.string :species, null: false
      t.string :breed
      t.string :name, null: false
      t.string :food, null: false
      t.string :diseases
      t.string :care

      t.timestamps
    end
  end
end
