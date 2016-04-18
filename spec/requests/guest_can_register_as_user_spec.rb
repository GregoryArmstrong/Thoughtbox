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

  scenario "Guest cannot sign up with an email address already used" do
    user_1 = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "pass")

    visit root_path

    expect(page).to have_content('Log In or Sign Up')

    click_on('Sign Up')

    expect(current_path).to eq new_user_path

    fill_in('Username', :with => 'GregArm_two')
    fill_in('Email', :with => 'intergalacticgentleman@gmail.com')
    fill_in('Password', :with => 'pass')
    fill_in('Password Confirmation', :with => 'pass')
    click_on('Submit')

    expect(current_path).to eq root_path
    expect(User.count).to eq 1
  end

  scenario "Guest must use matching password and password_confirmation" do
    visit root_path

    expect(page).to have_content('Log In or Sign Up')

    click_on('Sign Up')

    expect(current_path).to eq new_user_path

    fill_in('Username', :with => 'GregArm_two')
    fill_in('Email', :with => 'intergalacticgentleman@gmail.com')
    fill_in('Password', :with => 'pass')
    fill_in('Password Confirmation', :with => 'not_pass')
    click_on('Submit')

    expect(current_path).to eq root_path
    expect(User.count).to eq 0
  end

end
