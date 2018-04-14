# frozen_string_literal: true

class AddCreatorToCrops < ActiveRecord::Migration
  def change
    add_column :crops, :creator_id, :integer
  end
end
