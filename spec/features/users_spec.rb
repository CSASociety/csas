require 'rails_helper'

describe "the signup proccess", type: :feature do
  before :each do
    @user = build(:user)
    visit root_path
  end

  it "should sign me up with correct attrbutes and send confirmation email", js: true do
    click_link "Sign Up"
    within("#sign-up") do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password
      fill_in 'user[display_name]', with: @user.display_name
      click_button 'Sign up'
    end
    expect(page).to have_css('div#flash_notice')
  end

  #Check required on fields. All other validation are checked via unit test in models
  it "should require a email, display name, and passwords" do
    click_link "Sign Up"
    expect(page).to have_css("input#user_email[required]")
    expect(page).to have_css("input#user_password[required]")
    expect(page).to have_css("input#user_password_confirmation[required]")
    expect(page).to have_css("input#user_display_name[required]")
  end

  it "should give back an error if email taken"  do
    @user.save!
    click_link "Sign Up"
    within("#sign-up") do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password
      fill_in 'user[display_name]', with: @user.display_name
      click_button 'Sign up'
    end
    expect(page).to have_css('div#error_explanation')
  end

end


describe "the signin process", :type => :feature do
  before :each do
    @user = build(:user)
    @user.save!
    @user.confirm!
    visit root_path
  end

  it "signs me in", js: true do
    click_link 'Login'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    expect(page).to have_css('div#flash_notice')
  end

  it "should give back error is wrong password", js: true do
    click_link "Login"
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => "WrongPassword"
    click_button 'Sign in'
    expect(page).to have_css('div#flash_alert')
  end



end
