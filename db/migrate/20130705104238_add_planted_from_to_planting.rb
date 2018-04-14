# frozen_string_literal: true

class AddPlantedFromToPlanting < ActiveRecord::Migration
  def change
    add_column :plantings, :planted_from, :string
  end
end
