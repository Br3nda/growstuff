class Admin::MembersController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def index
    @members = Member.paginate(page: params[:page])
  end

  def show
  end

  def approve
    @member = Member.find(params[:member_id])
    @member.admin_approved = params[:admin_approved]
    @member.save!
    redirect_to admin_members_path
  end
end
