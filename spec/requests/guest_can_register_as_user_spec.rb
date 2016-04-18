require 'rails_helper'

RSpec.feature "GuestCanRegisterAsUser", type: :feature do
  Role.create(name: "registered_user")
  scenario "Guest instructed to sign up upon reaching root path" do
    visit root_path

    expect(current_path).to eq root_path

    expect(page).to have_content('Log In or Sign Up')

    click_on('Sign Up')

    expect(current_path).to eq new_user_path

    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password Confirmation')

    fill_in('Username', :with => 'GregArm')
    fill_in('Email', :with => 'intergalacticgentleman@gmail.com')
    fill_in('Password', :with => 'pass')
    fill_in('Password Confirmation', :with => 'pass')
    click_on('Submit')

    user = User.last

    expect(user.username).to eq "GregArm"
    expect(user.email_address).to eq "intergalacticgentleman@gmail.com"

    expect(current_path).to eq links_path
    expect(page).to have_content("Links Index")
  end

end
