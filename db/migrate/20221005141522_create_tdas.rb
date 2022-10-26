class CreateTdas < ActiveRecord::Migration[6.1]
  def change
    create_table :tdas do |t|
      t.string :name
      t.string :minute

      t.timestamps
    end
  end
end
