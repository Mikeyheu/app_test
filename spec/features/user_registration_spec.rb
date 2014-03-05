require 'spec_helper'

feature 'User registration' do
  scenario 'valid information' do
  	visit root_path
  	click_link 'Sign Up'
  	fill_in 'Email', with: 'mike@heu.com'
  	fill_in 'Password', with: 'password'
  	fill_in 'Password confirmation', with: 'password'
  	click_button 'Submit'
  	expect(page).to have_css 'div.notice', text: 'Thanks for signing up!'
  end

  scenario 'invalid information' do
  	visit root_path
  	click_link 'Sign Up'
  	fill_in 'Email', with: 'mike@heu.com'
  	fill_in 'Password', with: 'password'
  	fill_in 'Password confirmation', with: 'passwordddsffdsfds'
  	click_button 'Submit'
  	expect(page).to have_css 'div.error', text: 'Oops you fucked up!'
	end
end