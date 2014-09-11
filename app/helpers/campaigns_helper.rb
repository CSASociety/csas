module CampaignsHelper
  def user_is_active_player?(campaign, user)
    result = false
    campaign.players.active.each do |player|
      result = true if player.user_id == user.id
    end
    result
  end
end
