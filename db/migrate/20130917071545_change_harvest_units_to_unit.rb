# frozen_string_literal: true

class ChangeHarvestUnitsToUnit < ActiveRecord::Migration
  def change
    rename_column :harvests, :units, :unit
  end
end
