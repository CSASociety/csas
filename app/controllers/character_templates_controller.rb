class CharacterTemplatesController < ApplicationController
  load_and_authorize_resource param_method: :character_template_params

  def index
    @character_templates = CharacterTemplate.all
  end

  def new
    @character_template = CharacterTemplate.new
    @possible_images = Resource.where('file_content_type like ?', '%image%')
  end

  def create
    @character_template = CharacterTemplate.new(character_template_params)
    @character_template.user = current_user if current_user.present?
    if @character_template.save
      redirect_to @character_template, :notice => "Successfully created character."
    else
      render :action => 'new'
    end
  end

  def edit
    @character_template = CharacterTemplate.find(params[:id])
    @possible_images = Resource.where('file_content_type like ?', '%image%')
    if @character_template.image present?
      @possible_images = @possible_images - [@character_template.image]
    end
  end

  def update
    @character_template = CharacterTemplate.find(params[:id])
    params["character_template"] = params["character_template"].except("image_id") if params["character_template"]["image_id"].blank?
    if @character_template.update_attributes(character_template_params)
      redirect_to @character_template, :notice  => "Successfully updated character."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @character_template = CharacterTemplate.find(params[:id])
    @character_template.destroy
    redirect_to character_templates_url, :notice => "Successfully destroyed character."
  end

  def show
    @character_template = CharacterTemplate.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @character_template.attachments
    @possible_resources = Resource.all
    @attachments.each do  |attachment|
      @possible_resources  = @possible_resources  - [attachment.resource]
    end
    @possible_resources
  end

  private

  def character_template_params
    params.require(:character_template).permit(:player, :name, :caste, :bio, :gm_bio, :status, :image_id)
  end
end
