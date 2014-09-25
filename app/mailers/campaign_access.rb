class CampaignAccess < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def request_access(campaign, user)
    @user = user
    @campaign_title = campaign.title
    @gm = campaign.gm
    @url  = campaign_url(campaign)
    subject = "#{user.display_name} has requested access to a campaign"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    mail(to: @gm.email, subject: subject)
  end

  def invite_player(campaign, user)
    @user = user
    @campaign_title = campaign.title
    @gm = campaign.gm
    @url  = campaign_url(campaign)
    subject = "You have been invited to #{campaign.title}"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    mail(to: @user.email, subject: subject)
  end

end
