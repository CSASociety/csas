class CharctersController < ApplicationController
  def index
    @charcters = Charcter.all
  end

  def new
    @charcter = Charcter.new
    @possible_images = Resource.where('file_content_type like ?', '%image%')
  end

  def create
    @charcter = Charcter.new(charcter_params)
    if @charcter.save
      redirect_to @charcter, :notice => "Successfully created charcter."
    else
      render :action => 'new'
    end
  end

  def edit
    @charcter = Charcter.find(params[:id])
    @possible_images = Resource.where('file_content_type like ?', '%image%')
    if @charcter.image present?
      @possible_images = @possible_images - [@charcter.image]
    end
    @attachment = Attachment.new()
  end

  def update
    @charcter = Charcter.find(params[:id])
    if @charcter.update_attributes(charcter_params)
      redirect_to @charcter, :notice  => "Successfully updated charcter."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @charcter = Charcter.find(params[:id])
    @charcter.destroy
    redirect_to charcters_url, :notice => "Successfully destroyed charcter."
  end

  def show
    @charcter = Charcter.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @charcter.attachments
    @possible_resources = Resource.all
    @attachments.each do  |attachment|
      @possible_resources  = @possible_resources  - [attachment.resource]
    end
    @possible_resources
  end

  private

  def charcter_params
    params.require(:charcter).permit(:player, :name, :bio, :gm_bio, :status, :image_id)
  end
end
