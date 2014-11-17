require 'rails_helper'

describe "creation proccess", type: :feature do
  before :each do
    @user = create(:user)
    @user.confirm!
    login_as(@user, :scope => :user)
    @game = build(:game)
    visit games_path
  end

  it "should be able to create a game with correct attributes.", js: true do
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

describe "edit proccess proccess", type: :feature, js: true do
  before :each do
    @game = create(:game, :with_user)
    @user = @game.user
    login_as(@user, :scope => :user)
    visit game_path(@game)
  end

  it "should be able to edit", js: true do
    click_link 'Edit Game'
    expect(page).to have_css("input#game_title")
    fill_in 'game_title', with: 'Edited Game Title'
    click_button 'Update Game'
    expect(page).to have_content('Edited Game Title')
  end
end

describe "destroy process", type: :feature, js: true do
  before :each do
    @game = create(:game, :with_user)
    @user = @game.user
    login_as(@user, :scope => :user)
    visit edit_game_path(@game)
  end

  it "should have destory link with varifiction" do
    click_link 'Destroy Game'
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content(@game.title)
  end

  it "should not destory game when no is click on verfication" do
    click_link 'Destroy Game'
    page.driver.browser.switch_to.alert.dismiss
    expect(page).to have_css("input#game_title") 
  end

end
