require 'rails_helper'

feature "admin approval", :js do
  let(:member) { create :member, admin_approved: false }
  let!(:garden) { create :garden, owner: member }
  let!(:planting) { create :planting, garden: garden }
  let!(:harvest) { create :harvest, planting: planting }

  shared_examples "approved members only" do
    describe "un-approved member content does not show on page" do
      it { expect(page).to_not have_link garden }
      it { expect(page).to_not have_link planting }
      it { expect(page).to_not have_link harvest }
    end
  end

  context "when signed out" do
    before { visit root_path }
    it_behaves_like "approved members only"
  end

  context "when signed in" do
    before do
      login_as(member)
      visit root_path
    end
    it_behaves_like "approved members only"
  end
end
