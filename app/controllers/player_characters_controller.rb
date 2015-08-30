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
    @player_character.user = current_user if current_user.present?
    if @player_character.save
      redirect_to @player_character, :notice => "Successfully created character."
    else
      render :action => 'new'
    end
  end

  def edit
    @player_character = PlayerCharacter.find(params[:id])
  end

  def update
    @player_character = PlayerCharacter.find(params[:id])
    params["character"] = params["character"].except("image_id") if params["character"]["image_id"].blank?
    if @player_character.update_attributes(player_character_params)
      redirect_to @player_character, :notice  => "Successfully updated character."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player_character = PlayerCharacter.find(params[:id])
    @player_character.destroy
    redirect_to character_url, :notice => "Successfully destroyed character."
  end

  def show
    @player_character = PlayerCharacter.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @player_character.attachments
  end

  def quit
    @player_character = PlayerCharacter.find(params[:id])
    @campaign = @player_character.current_campaign
    if @player_character.stop!
      @player_character.current_campaign = nil
      @player_character.save
      @player_character.characters.where(campaign_id: @campaign.id).first.destroy
      redirect_to @player_character, notice: "#{@player_character.name} left the campaign: #{@campaign.title}"
    else
      redirect_to @player_character, alert: "Could not remove character from campaign"
    end
  end

  def join
    @player_character = PlayerCharacter.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @player_character.begin!
      @player_character.current_campaign = @campaign
      @player_character.save
      redirect_to @player_character, notice: "PlayerCharacter is now adventuring in this campaign"
    else
      redirect_to @player_character, alert: "Unable to proccess"
    end
  end

  def retire
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @player_character : request.referrer
    if @player_character.retire!
      redirect_to return_to, notice: "PlayerCharacter is now retired"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def kill
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "player_characters" ? @player_character : request.referrer
    if @player_character.kill!
      @player_character.current_campaign = nil
      @player_character.save
      redirect_to return_to, notice: "PlayerCharacter is now dead"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def lose
    @player_character = PlayerCharacter.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @player_character : request.referrer
    if @player_character.lose!
      @player_character.current_campaign = nil
      @player_character.save
      redirect_to return_to, notice: "PlayerCharacter is now missing"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def resurrect
    @player_character = PlayerCharacter.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @player_character.begin!
      @player_character.current_campaign = @campaign
      if @player_character.save
        redirect_to @player_character, notice: "Player Character has been resurrected and has joined the campaign: #{@campaign.title}"
      else
        @player_character.stop!
        redirect_to @player_character, notice: "Player Character has been resurrected but was unable to join the campaign: #{@campaign.title}"
      end
    else
      redirect_to @player_character, alert: "Player Character was unable to be resurrected"
    end
  end

  def find
    @player_character = PlayerCharacter.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @player_character.begin!
      @player_character.current_campaign = @campaign
      @player_character.save
      redirect_to @player_character, notice: "PlayerCharacter found in campaign: #{@campaign.title}"
    else
      redirect_to @player_character, alert: "PlayerCharacter unable to be found and added to campaign: #{@campaign.title}"
    end
    #this adds a chacter to a campaign via being found
  end

  def clone
    ## This will just create new character with all the same states
  end

  private

  def player_character_params
    params.require(:player_character).permit(:user, :name, :caste, :bio, :gm_bio, :status, :image, :user_id)
  end
end
