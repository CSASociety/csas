class PlayerCharactersController < ApplicationController
  load_and_authorize_resource param_method: :player_character_params

  def index
    @player_characters = PlayerCharacter.all
  end

  def new
    @player_character = PlayerCharacter.new
  end

  def create
    @player_character = PlayerCharacter.new(player_character_params)
    if @player_character.save
      if request.referrer.match('player_characters')
        redirect_to @player_character, :notice  => "Successfully add character to the campaign."
      else
        redirect_to request.referrer, :notice  => "Successfully add character to the campaign."
      end
    else
      if request.referrer.match('player_characters')
        flash['alert'] = "Failed to add character to this campaign."
        render "new"
      else
        redirect_to request.referrer, :notice  => "Unable to add character to the campaign."
      end
    end
  end

  def show
    @player_character = PlayerCharacter.find(params[:id])
  end

  def destroy
    @player_character = PlayerCharacter.find(params[:id])
    if @player_characters.destroy
      redirect_to campaign_path(@player_characters.campaign.id), :notice  => "Removed character to this campaign."
    else
      redirect_to campaign_path(@player_characters.campaign.id), :notice  => "Failed to remove character to this campaign."
    end
  end

  #Figure out how to dry this up. Maybe one action with a argument.
  def join
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.join!
      redirect_to return_to, notice: "Character is now adventuring in this campaign"
    else
      flash[:alert] = "Unable to proccess"
      render 'show'
    end
  end

  def retire
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.retire!
      redirect_to return_to, notice: "Character is now retired"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def kill
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.kill!
      redirect_to return_to, notice: "Character is now dead"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def lose
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.lose!
      redirect_to return_to, notice: "Character is now missing"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  private

  def player_character_params
    params.require(:player_character).permit(:campaign_id, :character_template_id, :status)
  end
end
