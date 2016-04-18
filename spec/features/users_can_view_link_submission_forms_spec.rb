require 'rails_helper'

RSpec.feature "UsersCanViewLinkSubmissionForms", type: :feature do
  scenario "registered user can submit valid link via submission form on links#index" do
    role = Role.create(name: "registered_user")
    user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
    user.roles << role

    visit root_path

    click_on('Sign In')

    fill_in('Username', :with => 'GregArm')
    fill_in('Password', :with => 'password')
    click_on('Login')

    visit links_path

    expect(page).to have_content("Submit a Link")
    expect(page).to have_content("URL")
    expect(page).to have_content("Title")

    expect(Link.count).to eq 0

    fill_in('URL', :with => 'http://today.turing.io')
    fill_in('Title', :with => "Turing Today")
    click_on('Submit Link')

    expect(Link.count).to eq 1
    expect(current_path).to eq links_path
    expect(page).to have_content('http://today.turing.io')
    expect(page).to have_content("Turing Today")
    expect(page).to have_content("Mark as Read")
  end

  scenario "registered user cannot submit invalid link via submission form on links#index" do
    role = Role.create(name: "registered_user")
    user = User.create(username: 'GregArm', email_address: "intergalacticgentleman@gmail.com", password: "password")
    user.roles << role

    visit root_path

    click_on('Sign In')

    fill_in('Username', :with => 'GregArm')
    fill_in('Password', :with => 'password')
    click_on('Login')

    visit links_path

    expect(page).to have_content("Submit a Link")
    expect(page).to have_content("URL")
    expect(page).to have_content("Title")


    expect(Link.count).to eq 0

    fill_in('URL', :with => 'cheese')
    fill_in('Title', :with => "Turing Today")
    click_on('Submit Link')

    expect(Link.count).to eq 0
    expect(page).to have_content("Invalid URL Submitted.")
    expect(current_path).to eq links_path
    expect(page).to_not have_content('cheese')
    expect(page).to_not have_content("Turing Today")
    expect(page).to_not have_content("Mark as Read")
  end

end
