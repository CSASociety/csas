require 'rails_helper'

describe "creation proccess", type: :feature do
  before :each do
    @user = create(:user)
    @user.confirm!
    login_as(@user, :scope => :user)
    @game = build(:game)
    visit games_path
  end

  it "should be able to create a game with correct attributes." do
    click_link "Create New Game"
    fill_in 'game[title]', with: @game.title
    fill_in 'game[description]', with: @game.description
    fill_in 'game[link]', with: @game.link
    click_button 'Create Game'
    expect(page).to have_css('div#flash_notice')
  end

  it "should not allow duplicate titles", js: true do
    @game.save
    click_link "Create New Game"
    fill_in 'game[title]', with: @game.title
    fill_in 'game[description]', with: @game.description
    fill_in 'game[link]', with: @game.link
    click_button 'Create Game'
    expect(page).to have_css('div#flash_alert')
  end
end

