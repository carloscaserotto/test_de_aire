class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :speciality
      t.string :mn

      t.timestamps
    end
  end
end
