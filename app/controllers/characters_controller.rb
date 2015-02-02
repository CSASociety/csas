class CharactersController < ApplicationController
  load_and_authorize_resource param_method: :character_params

  def index
    @characters = Character.all
  end

  def new
    @character = Character.new
    @possible_images = Resource.where('file_content_type like ?', '%image%')
  end

  def create
    @character = Character.new(character_params)
    @character.user = current_user if current_user.present?
    if @character.save
      redirect_to @character, :notice => "Successfully created character."
    else
      render :action => 'new'
    end
  end

  def edit
    @character = Character.find(params[:id])
    @possible_images = Resource.where('file_content_type like ?', '%image%')
    if @character.image present?
      @possible_images = @possible_images - [@character.image]
    end
  end

  def update
    @character = Character.find(params[:id])
    params["character"] = params["character"].except("image_id") if params["character"]["image_id"].blank?
    if @character.update_attributes(character_params)
      redirect_to @character, :notice  => "Successfully updated character."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to character_url, :notice => "Successfully destroyed character."
  end

  def show
    @character = Character.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @character.attachments
    @possible_resources = Resource.all
    @attachments.each do  |attachment|
      @possible_resources  = @possible_resources  - [attachment.resource]
    end
    @possible_resources
  end

  def begin
    @player_character = Character.find(params[:id])
    @campaign = Campaign.find(params[:campaign][:id])
    debugger
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.join!
      redirect_to return_to, notice: "Character is now adventuring in this campaign"
    else
      flash[:alert] = "Unable to proccess"
      render 'show'
    end
  end

  def resting(campaign)

  end

  def retire
    @character = Character.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @character : request.referrer
    if @character.retire!
      redirect_to return_to, notice: "Character is now retired"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def kill
    @character = Character.find(params[:id])
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

  def ressurect
    #This should bring the character into a campaign via a campaign
  end

  def find(campaign)
    #this adds a chacter to a campaign via being found
  end

  def clone
    ## This will just create new character with all the same states
  end

  private

  def character_params
    params.require(:character).permit(:player, :name, :caste, :bio, :gm_bio, :status, :image_id)
  end
end
