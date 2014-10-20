require 'rails_helper'
describe "the signin process", :type => :feature do
  before :each do
    @user = build(:user)
    @user.save!
    @user.confirm!
  end

  it "signs me in", js: true do
    visit root_path
    click_link 'Login'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
end
