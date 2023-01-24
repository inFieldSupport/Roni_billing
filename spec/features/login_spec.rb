require 'rails_helper'
RSpec.describe 'Login', type: :feature do
    before :each do
        Employee.create(name:"ANy",email:"roni@gmail.com",password:"foobar",password_confirmation:"foobar" )
    end
    scenario 'successful sign in ' do
        visit root_path
        fill_in "Email", with: 'roni@gmail.com'
        fill_in "Password", with: 'foobar'
        click_on 'Sign in'
        expect(page).to have_text("Clients")
        expect(page).to have_text("Logout")
    end
    scenario 'invalid email ' do
        visit root_path
        fill_in "Email", with: 'ron@gmail.com'
        fill_in "Password", with: 'foobar'
        click_on 'Sign in'
        expect(page).to have_text("Sign in")
       
    end
    scenario 'invalid password ' do
        visit root_path
        fill_in "Email", with: 'roni@gmail.com'
        fill_in "Password", with: 'a'
        click_on 'Sign in'
        expect(page).to have_text("Sign in")
       
    end
    scenario 'logout ' do
        visit root_path
        fill_in "Email", with: 'roni@gmail.com'
        fill_in "Password", with: 'foobar'
        click_on 'Sign in'
        expect(page).to have_text("Logout")
        visit root_path
        click_on 'Logout'
        expect(page).to have_text("Sign in")
        
    end
end