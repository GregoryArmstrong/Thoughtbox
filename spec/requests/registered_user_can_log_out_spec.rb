require 'rails_helper'

RSpec.feature "RegisteredUserCanLogOut", type: :feature do
  Role.create(name: "registered_user")
    scenario "Registered user can log out" do
      visit root_path

      click_on('Sign Up')

      fill_in('Username', :with => 'GregArm')
      fill_in('Email', :with => 'intergalacticgentleman@gmail.com')
      fill_in('Password', :with => 'pass')
      fill_in('Password Confirmation', :with => 'pass')
      click_on('Submit')

      expect(current_path).to eq links_path

      expect(page).to have_content "Links Index"

      click_on("Log Out")

      expect(current_path).to eq root_path
    end
end
