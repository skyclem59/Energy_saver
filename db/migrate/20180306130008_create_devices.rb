class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.references :type, foreign_key: true
      t.references :house, foreign_key: true

      t.timestamps
    end
  end
end
