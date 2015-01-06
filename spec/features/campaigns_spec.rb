require 'rails_helper'

describe "creation proccess", type: :feature do
  before :each do
    @user = create(:user, :confirmed)
    login_as(@user, :scope => :user)
    @campaign = build(:campaign)
    visit campaigns_path
  end

  it "should be able to create a campaign", js: true do
    click_link "Create New Campaign"
    fill_in 'campaign[title]', with: @campaign.title
    fill_in 'campaign[description]', with: @campaign.description
    fill_in 'campaign[link]', with: @campaign.link
    click_button 'Create Campaign'
    expect(page).to have_css('div#flash_notice')
  end
end

describe "Edit proccess", type: :feature do
  before :each do
    @campaign = create(:campaign, :with_gm)
    @user = @campaign.gm
    login_as(@user, :scope => :user)
    visit campaign_path(@campaign)
  end

  it "should be able to edit a campaign", js: true do
    expect(@user.email).to eq('gm@example.com')
    click_link "Edit Campaign"
    expect(page).to have_css("input#campaign_title")
    fill_in 'campaign[title]', with: "Updated Title"
    click_button 'Update Campaign'
    expect(page).to have_content("Updated Title")
  end
end

describe "destroy process", type: :feature, js: true do
  before :each do
    @campaign = create(:campaign, :with_gm)
    @user = @campaign.gm
    login_as(@user, :scope => :user)
    visit edit_campaign_path(@campaign)
  end

  it "should have destory link with varifiction" do
    click_link 'Destroy Campaign'
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content(@campaign.title)
  end

  it "should not destory game when no is click on verfication" do
    click_link 'Destroy Campaign'
    page.driver.browser.switch_to.alert.dismiss
    expect(page).to have_css("input#campaign_title") 
  end

end

describe "Add a player", type: :feature, js: true do
  before :each do
    @campaign = create(:campaign, :with_gm)
    @gm = @campaign.gm
    @reg_user = create(:user, :confirmed, display_name: 'reg_user')
  end

  describe "invite path", type: :feature, js: true do
    before :each do
      login_as(@gm, scope: :user)
      visit campaign_path(@campaign)
      click_link('Invite Player')
      select(@reg_user.display_name, :from => 'player_user_id')
      click_button('Create Player')
    end

    it "should be able to invite a player as the GM" do
      expect(page).to have_content(@reg_user.display_name)
    end

    it "should allow user to accept the request" do
      logout
      login_as(@reg_user, scope: :user)
      visit campaign_path(@campaign)
      click_button('Accept Request')
      expect(page).to have_selector("div#player_1", text: "Status: active")
    end

     it "should allow user to reject the request" do
      logout
      login_as(@reg_user, scope: :user)
      visit campaign_path(@campaign)
      click_button('Reject Request')
      expect(page).to have_selector("div#player_1", text: "Status: denied")
    end

    it "should allow gm to remove the player" do
      @player = create(:player, user: @reg_user, campaign: @campaign, status: "active")
      logout
      login_as(@reg_user, scope: :user)
      expect(page).to have_selector("div#player_1", text: "Status: active")
    end


  end

  describe "request path", type: :feature, js: true do
    it "should be able to request to be a player as a user" do
      login_as(@reg_user, scope: :user)
      visit campaign_path(@campaign)
      click_button('Request Access')
      expect(page).to have_content("Player Name: #{@reg_user.display_name}")
    end
  end

end
