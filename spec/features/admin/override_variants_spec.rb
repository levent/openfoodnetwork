require 'spec_helper'

feature %q{
  As an Administrator
  With products I can add to order cycles
  I want to override the stock level and price of those products
  Without affecting other hubs that share the same products
}, js: true do
  include AuthenticationWorkflow
  include WebHelper

  before do
    login_to_admin_section
  end

  use_short_wait

  describe "selecting a hub" do
    let!(:hub) { create(:distributor_enterprise) }

    it "displays a list of hub choices" do
      visit '/admin/products/override_variants'
      page.should have_select2 'hub_id', with_options: [hub.name]
    end
  end
end
