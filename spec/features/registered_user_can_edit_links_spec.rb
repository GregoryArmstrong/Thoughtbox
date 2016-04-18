require 'rails_helper'

RSpec.feature "RegisteredUserCanEditLinks", type: :feature do
  scenario "registered user can edit links with valid info" do
    user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
    user.roles.create(name: "registered_user")
    user.links.create(url: "http://today.turing.io", title: "Turing!")

    visit root_path

    click_on('Sign In')

    fill_in('Username', :with => 'GregArm')
    fill_in('Password', :with => 'password')
    click_on('Login')

    expect(page).to have_content("Edit")

    click_on("Edit")

    fill_in('URL', :with => 'http://yesterday.turing.io')
    fill_in('Title', :with => "Yesterday!")
    click_on('Submit')

    expect(current_path).to eq links_path
    expect(page).to_not have_content("http://today.turing.io")
    expect(page).to_not have_content("Turing!")
    expect(page).to have_content("http://yesterday.turing.io")
    expect(page).to have_content("Yesterday!")
  end

  scenario "registered user cannot edit links with invalid info" do
    user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
    user.roles.create(name: "registered_user")
    user.links.create(url: "http://today.turing.io", title: "Turing!")

    visit root_path

    click_on('Sign In')

    fill_in('Username', :with => 'GregArm')
    fill_in('Password', :with => 'password')
    click_on('Login')

    expect(page).to have_content("Edit")

    click_on("Edit")

    fill_in('URL', :with => 'cheese')
    fill_in('Title', :with => "Yesterday!")
    click_on('Submit')

    expect(current_path).to eq links_path
    expect(page).to have_content("http://today.turing.io")
    expect(page).to have_content("Turing!")
    expect(page).to_not have_content("http://yesterday.turing.io")
    expect(page).to_not have_content("Yesterday!")
  end
end
