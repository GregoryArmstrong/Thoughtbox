require 'rails_helper'

RSpec.feature "RegisteredUserCanLogIn", type: :feature do
    scenario "Registered user can log in" do
      role = Role.create(name: "registered_user")
      user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
      user.roles << role
      visit root_path

      click_on('Sign In')

      expect(current_path).to eq new_session_path

      fill_in('Username', :with => 'GregArm')
      fill_in('Password', :with => 'password')
      click_on('Login')

      expect(current_path).to eq links_path

      expect(page).to have_content "Links Index"
    end
end
