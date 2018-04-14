# frozen_string_literal: true

class AddCreatorToScientificName < ActiveRecord::Migration
  def change
    add_column :scientific_names, :creator_id, :integer
  end
end
