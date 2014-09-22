class CampaignsController < ApplicationController
  load_and_authorize_resource param_method: :campaign_params

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
    @possible_images = Resource.where('file_content_type like ?', '%image%')
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.gm = current_user if current_user.present?
    if @campaign.save
      redirect_to @campaign, :notice => "Successfully created campaign."
    else
      render :action => 'new'
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @possible_images = Resource.where('file_content_type like ?', '%image%')
    if @campaign.image present?
      @possible_images = @possible_images - [@campaign.image]
    end
    @attachment = Attachment.new()
  end

  def update
    #TODO This next line stone the image form being delete when no new image is being selected. This seems like bad practise. Need to find a better way
    params["campaign"] = params["campaign"].except("image_id") if params["campaign"]["image_id"].blank?
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(campaign_params)
      redirect_to @campaign, :notice  => "Successfully updated campaign."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_url, :notice => "Successfully destroyed campaign."
  end

  def show
    @campaign = Campaign.find(params[:id])
    @attachments = @campaign.attachments
    @possible_resources = Resource.all
    @attachments.each do  |attachment|
      @possible_resources  = @possible_resources  - [attachment.resource]
    end
    @possible_players = User.all
    @campaign.users.each do |user|
      @possible_players =  @possible_players - [user]
    end
    if current_user.present? && @campaign.user_is_active_player?(current_user)
      @current_player = Player.where(campaign_id: @campaign.id, user_id: current_user.id).first
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :link, :image_id, :intro, :game_id)
  end
end
