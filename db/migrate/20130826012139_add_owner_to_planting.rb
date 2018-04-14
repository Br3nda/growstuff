# frozen_string_literal: true

class AddOwnerToPlanting < ActiveRecord::Migration
  def change
    add_column :plantings, :owner_id, :integer
  end
end
