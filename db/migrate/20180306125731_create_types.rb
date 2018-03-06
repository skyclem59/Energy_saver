class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :name
      t.string :method
      t.string :key_user
      t.string :key_password
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
