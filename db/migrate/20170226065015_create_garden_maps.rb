class CreateGardenMaps < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.references :garden
      t.integer :x
      t.integer :y
      t.references :planting
      t.timestamps null: false
    end

    add_column :gardens, :width, :integer
    add_column :gardens, :length, :inte ger
  end
end
