class DiaryController < ApplicationController
  def index
    @member = current_member
  end
end
