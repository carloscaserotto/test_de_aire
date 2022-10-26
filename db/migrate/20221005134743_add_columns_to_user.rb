class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mn, :string
    add_column :users, :speciality, :string
  end
end
