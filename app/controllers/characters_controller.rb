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
  end

  def quit
    @character = Character.find(params[:id])
    @campaign = @character.current_campaign
    if @character.stop!
      @character.current_campaign = nil
      @character.save
      redirect_to @character, notice: "#{@character.name} left the campaign: #{@campaign.title}"
    else
      redirect_to @character, alert: "Could not remove character from campaign"
    end
  end

  def join
    @character = Character.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @character.begin!
      @character.current_campaign = @campaign
      @character.save
      redirect_to @character, notice: "Character is now adventuring in this campaign"
    else
      redirect_to @character, alert: "Unable to proccess"
    end
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
    if @character.kill!
      @character.current_campaign = nil
      @character.save
      redirect_to return_to, notice: "Character is now dead"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def lose
    @character = Character.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @character : request.referrer
    if @character.lose!
      @character.current_campaign = nil
      @character.save
      redirect_to return_to, notice: "Character is now missing"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  def resurrect
    @character = Character.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @character.begin!
      @character.current_campaign = @campaign
      if @character.save
        redirect_to @character, notice: "Character has been resurrected and has joined the campaign: #{@campaign.title}"
      else
        @character.stop!
        redirect_to @character, notice: "Character has been resurrected but was unable to join the campaign: #{@campaign.title}"
      end
    else
      redirect_to @character, alert: "Character was unable to be resurrected"
    end
  end

  def find
    @character = Character.find(params[:id])
    @campaign = Campaign.find(params[:campaign])
    if @character.begin!
      @character.current_campaign = @campaign
      @character.save
      redirect_to @character, notice: "Character found in campaign: #{@campaign.title}"
    else
      redirect_to @character, alert: "Character unable to be found and added to campaign: #{@campaign.title}"
    end
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
