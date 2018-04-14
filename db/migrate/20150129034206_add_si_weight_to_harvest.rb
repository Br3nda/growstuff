# frozen_string_literal: true

class AddSiWeightToHarvest < ActiveRecord::Migration
  def change
    add_column :harvests, :si_weight, :float
  end
end
