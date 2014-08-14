class CampaignCharactersController < ApplicationController
  def index
    @campaign_characters = CampaignCharacter.all
  end

  def new
    @campaign_character = CampaignCharacter.new
  end

  def create
    @campaign_character = CampaignCharacter.new(campaign_character_params)
    if @campaign_character.save
      if request.referrer.match('campaign_characters')
        redirect_to @campaign_character, :notice  => "Successfully add character to the campaign."
      else
        redirect_to request.referrer, :notice  => "Successfully add character to the campaign."
      end
    else
      if request.referrer.match('campaign_characters')
        flash['alert'] = "Failed to add character to this campaign."
        render "new"
      else
        redirect_to request.referrer, :notice  => "Unable to add character to the campaign."
      end
    end
  end

  def show
    @campaign_character = CampaignCharacter.find(params[:id])
  end

  def destroy
    @campaign_character = CampaignCharacter.find(params[:id])
    if @campaign_characters.destroy
      redirect_to campaign_path(@campaign_characters.campaign.id), :notice  => "Removed character to this campaign."
    else
      redirect_to campaign_path(@campaign_characters.campaign.id), :notice  => "Failed to remove character to this campaign."
    end
  end

  private

  def campaign_character_params
    params.require(:campaign_character).permit(:campaign_id, :character_id, :status)
  end
end
