module CampaignsHelper
  def user_is_active_player?(campaign, user=nil)
    result = false
    campaign.players.active.each do |player|
      result = true if user.present? && player.user_id == user.id
    end
    result
  end
end
