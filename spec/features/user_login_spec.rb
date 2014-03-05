require 'spec_helper'

feature 'User Login' do 
	scenario 'with valid information' do
		user = User.create!(email:'mike@heu.com', password:'password', password_confirmation:'password')
		visit root_path
  	click_link 'Login'
  	fill_in 'Email', with: 'mike@heu.com'
  	fill_in 'Password', with: 'password'
  	click_button 'Submit'
  	expect(page).to have_text 'mike@heu.com'
	end

	scenario 'with invalid information'
end