# frozen_string_literal: true

class AddBioToMembers < ActiveRecord::Migration
  def change
    add_column :members, :bio, :text
  end
end
