# frozen_string_literal: true

class RenameAccountDetailToAccount < ActiveRecord::Migration
  def change
    rename_table :account_details, :accounts
  end
end
