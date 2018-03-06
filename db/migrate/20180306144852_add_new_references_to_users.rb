class AddNewReferencesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :house, foreign_key: true
  end
end
