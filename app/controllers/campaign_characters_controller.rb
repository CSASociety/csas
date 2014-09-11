class CampaignCharactersController < ApplicationController
  load_and_authorize_resource param_method: :campaign_character_params

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

  #Figure out how to dry this up. Maybe one action with a argument.
  def join
    @cc = CampaignCharacter.find(params[:id])
    authorize! :update, @cc
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "campaign_characters" ? @cc : request.referrer
    if @cc.join!
      redirect_to return_to, notice: "Character is now adventuring in this campaign"
    else
      flash[:alert] = "Unable to proccess"
      render 'show'
    end
  end

  def retire
    @cc = CampaignCharacter.find(params[:id])
    authorize! :update, @cc
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "campaign_characters" ? @cc : request.referrer
    if @cc.retire!
      redirect_to return_to, notice: "Character is now retired"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def kill
    @cc = CampaignCharacter.find(params[:id])
    authorize! :update, @cc
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "campaign_characters" ? @cc : request.referrer
    if @cc.kill!
      redirect_to return_to, notice: "Character is now dead"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def lose
    @cc = CampaignCharacter.find(params[:id])
    authorize! :update, @cc
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "campaign_characters" ? @cc : request.referrer
    if @cc.lose!
      redirect_to return_to, notice: "Character is now missing"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  private

  def campaign_character_params
    params.require(:campaign_character).permit(:campaign_id, :character_id, :status)
  end
end
