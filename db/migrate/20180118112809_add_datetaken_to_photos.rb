# frozen_string_literal: true

class AddDatetakenToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :date_taken, :datetime
  end
end
