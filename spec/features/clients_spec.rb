# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Client', type: :feature do
  before :each do
    @employee = Employee.create(name: 'ANy', email: 'roni@gmail.com', password: 'foobar',
                                password_confirmation: 'foobar')

    visit root_path
    fill_in 'Email', with: 'roni@gmail.com'
    fill_in 'Password', with: 'foobar'
    click_on 'Sign in'
    @client = Client.create(name: 'Roni', company_name: 'Any', email: 'example@gmail.com', address: 'Any')
    # @standard = Standard.create(client_id:@client.id,standard_rate:32,standard_type:"Telematics",active_users:32)
  end
  scenario 'view clients' do
    @user = User.create(id: 1, client_id: @client.id, user_rate: 32, user_type: 'Admin', active_users: 32,registered_users:50,month:"January",year:2023)
    @standard = Standard.create(client_id: @client.id, standard_rate: 32, standard_type: 'Telematics',
                                active_users: 32,month:"January",year:2023)
    visit root_path

    expect(page).to have_text('Clients')
    expect(page).to have_text('Any')
    click_on 'View'
    expect(page).to have_text('Any')
    expect(page).to have_text('Users')
    expect(page).to have_text('Admin')
    expect(page).to have_text('SubTotal')
  end
  scenario 'edit user' do
    @user = User.create(id: 1, client_id: @client.id, user_rate: 32, user_type: 'Admin', active_users: 32,registered_users:50,month:"January",year:2023)
    visit root_path
    expect(page).to have_text('Clients')
    expect(page).to have_text('Any')
    click_on 'View'
    click_on 'Create'
    expect(page).to have_text('Invoice')

    # fill_in :active_users,with: "33"
    # fill_in "user-rate-#{@user.id}",with: "33"
    # click_on "Save"
  end
  scenario 'search clients' do
    visit root_path
    fill_in 'client_company_name', with: 'a'
    click_on 'Search'
    expect(page).to have_text('Any')
    fill_in 'client_company_name', with: 'b'
    click_on 'Search'
    expect(page).not_to have_text('Any')
  end
end
