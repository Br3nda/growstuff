# frozen_string_literal: true

class AddShowEmailToMember < ActiveRecord::Migration
  def change
    add_column :members, :show_email, :boolean
  end
end
