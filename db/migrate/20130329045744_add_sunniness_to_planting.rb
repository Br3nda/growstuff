# frozen_string_literal: true

class AddSunninessToPlanting < ActiveRecord::Migration
  def change
    add_column :plantings, :sunniness, :string
  end
end
