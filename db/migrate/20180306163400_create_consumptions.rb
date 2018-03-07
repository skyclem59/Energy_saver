class CreateConsumptions < ActiveRecord::Migration[5.1]
  def change


        create_table :consumptions do |t|
      t.string :energy
      t.timestamp :stamp
      t.float :value
      t.integer :alwayson

      t.timestamps
    end
  end
end
