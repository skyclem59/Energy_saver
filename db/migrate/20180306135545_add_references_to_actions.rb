class AddReferencesToActions < ActiveRecord::Migration[5.1]
  def change
    add_reference :actions, :type, foreign_key: true
  end
end
