class AddColumnsToPatient < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :lastname, :string
    add_column :patients, :cobertura, :string
  end
end
