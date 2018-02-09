class GardenLayout < ActiveRecord::Migration
  def change
    add_column :gardens, :width, :integer
    add_column :gardens, :length, :integer
  end
end
