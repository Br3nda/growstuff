# frozen_string_literal: true

class AddRequestNotesToCrops < ActiveRecord::Migration
  def change
    add_column :crops, :request_notes, :text
  end
end
