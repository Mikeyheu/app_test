require 'spec_helper'

feature 'View the home page' do
  scenario 'user sees home page content' do
    visit root_path
    expect(page).to have_css 'title', text: 'App Test', visible: false
  end
end