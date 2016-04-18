require 'rails_helper'

RSpec.feature "RegisteredUserCanReadOrUnreadLinks", type: :feature do
  scenario "registered user can mark unread links as read" do
    user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
    user.roles.create(name: "registered_user")
    user.links.create(url: "http://today.turing.io", title: "Turing!")

    visit root_path

    click_on('Sign In')

    fill_in('Username', :with => 'GregArm')
    fill_in('Password', :with => 'password')
    click_on('Login')

    visit links_path

    expect(Link.last.read).to eq false

    expect(page).to have_content("http://today.turing.io")
    expect(page).to have_content("Turing!")
    expect(page).to have_content("Mark as Read")

    click_on('Mark as Read')

    expect(Link.last.read).to eq true

    click_on('Mark as Unread')

    expect(Link.last.read).to eq false
  end
end
