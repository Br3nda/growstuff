# frozen_string_literal: true

class RenamePostMemberToAuthor < ActiveRecord::Migration
  def change
    rename_column :posts, :member_id, :author_id
  end
end
