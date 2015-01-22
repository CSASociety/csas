class PlayerCharactersController < ApplicationController
  load_and_authorize_resource param_method: :player_character_params

  def index
    @player_characters = PlayerCharacter.all
  end

  def new
    @player_character = PlayerCharacter.new
    @possible_images = Resource.where('file_content_type like ?', '%image%')
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

  def edit
    @player_character = PlayerCharacter.find(params[:id])
    @possible_images = Resource.where('file_content_type like ?', '%image%')
    if @player_character.image present?
      @possible_images = @possible_images - [@player_character.image]
    end
  end

  def update
    @player_character = PlayerCharacter.find(params[:id])
    params["player_character"] = params["player_character"].except("image_id") if params["player_character"]["image_id"].blank?
    if @player_character.update_attributes(player_character_params)
      redirect_to @player_character, :notice  => "Successfully updated PC."
    else
      render :action => 'edit'
    end
  end

  def show
    @player_character = PlayerCharacter.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @player_character.attachments
    @possible_resources = Resource.all
    @attachments.each do  |attachment|
      @possible_resources  = @possible_resources  - [attachment.resource]
    end
    @possible_resources
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
    params.require(:player_character).permit(:name, :caste, :campaign_id, :description, :bio, :secrets, :player_id, :character_id, :image_id, :status)
  end
end
