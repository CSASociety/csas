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
    @attachment = Attachment.new()
  end

  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(character_params)
      redirect_to @character, :notice  => "Successfully updated character."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_url, :notice => "Successfully destroyed character."
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

  private

  def character_params
    params.require(:character).permit(:player, :name, :class, :bio, :gm_bio, :status, :image_id)
  end
end
