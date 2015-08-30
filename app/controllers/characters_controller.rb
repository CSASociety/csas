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
    if @character.save
      if request.referrer.match('characters')
        redirect_to @character, :notice  => "Successfully add character to the campaign."
      else
        redirect_to request.referrer, :notice  => "Successfully add character to the campaign."
      end
    else
      if request.referrer.match('characters')
        flash['alert'] = "Failed to add character to this campaign."
        render "new"
      else
        redirect_to request.referrer, :notice  => "Unable to add character to the campaign."
      end
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
      redirect_to @character, :notice  => "Successfully updated PC."
    else
      render :action => 'edit'
    end
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

  def destroy
    @character = Character.find(params[:id])
    if @characters.destroy
      redirect_to campaign_path(@characters.campaign.id), :notice  => "Removed character to this campaign."
    else
      redirect_to campaign_path(@characters.campaign.id), :notice  => "Failed to remove character to this campaign."
    end
  end

  #Figure out how to dry this up. Maybe one action with a argument.
  def join
    @character = Character.find(params[:id])
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @character : request.referrer
    if @character.join!
      redirect_to return_to, notice: "Character is now adventuring in this campaign"
    else
      flash[:alert] = "Unable to proccess"
      render 'show'
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
    return_to =  Rails.application.routes.recognize_path(request.referrer)[:controller] == "characters" ? @character : request.referrer
    if @character.kill!
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
      redirect_to return_to, notice: "Character is now missing"
    else
      flash[:alert] = "Unable to proccess "
      render 'show'
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :caste, :campaign_id, :description, :bio, :secrets, :player_id, :character_id, :image_id, :status)
  end
end
