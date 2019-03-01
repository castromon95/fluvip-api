class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
