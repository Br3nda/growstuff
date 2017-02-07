class AddAdminApprovedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :admin_approved, :boolean
    Member.update_all admin_approved: true # rubocop:disable Rails/SkipsModelValidations
  end
end
