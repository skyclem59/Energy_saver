class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :api_param
      
      t.timestamps
    end
  end
end
