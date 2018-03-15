class AddTokensToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :token, :string
    add_column :devices, :refresh_token, :string
    add_column :devices, :expires_in, :integer
  end
end
