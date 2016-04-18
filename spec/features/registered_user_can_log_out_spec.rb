require 'rails_helper'

RSpec.feature "RegisteredUserCanLogOut", type: :feature do
    scenario "Registered user can log out" do
      Role.create(name: "registered_user")
      visit root_path

      click_on('Sign Up')

      fill_in('Username', :with => 'GregArmLogout')
      fill_in('Email', :with => 'intergalacticgentleman@gmail.com')
      fill_in('Password', :with => 'password')
      fill_in('Password Confirmation', :with => 'password')
      click_on('Submit')

      expect(current_path).to eq links_path

      expect(page).to have_content "Links Index"

      click_on("Log Out")

      expect(current_path).to eq root_path
    end
end
