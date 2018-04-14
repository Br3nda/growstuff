# frozen_string_literal: true

class AddReferralCodeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :referral_code, :string
  end
end
