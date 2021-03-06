class CampaignsController < ApplicationController
  load_and_authorize_resource param_method: :campaign_params

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
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
    @possible_players = User.confirmed
    @campaign.users.each do |user|
      @possible_players =  @possible_players - [user]
    end
    if current_user.present? && @campaign.user_is_active_player?(current_user)
      @current_player = Player.where(campaign_id: @campaign.id, user_id: current_user.id).first
      @possible_player_characters = current_user.player_characters - @campaign.player_characters
    end
  end

  def attach_event
    @campaign = Campaign.find(params[:id])
    @event = Event.find(params[:campaign][:events])
    @campaign.events << @event
    if @campaign.save
      delay = EventMailer.delay(run_at: (@event.start_at - 24.hours)).reminder(@event) if @event.reminder.nil?
      @event.reminder = delay.id
      @event.save
      redirect_to @campaign, :notice => "Successfully added event to campaign."
    end
  end

  def add_pc
    @campaign = Campaign.find(params[:id])
    @player_character = PlayerCharacter.find(params[:character])
    if @player_character.status == 'resting' && !@campaign.player_characters.include?(@player_character)
      @campaign.player_characters << @player_character
      if @campaign.save
        @player_character.begin
        @player_character.current_campaign = @campaign
        @player_character.player = current_user.players.where(campaign_id: params[:id]).name
        @player_character.save
        redirect_to campaign_path(@campaign), notice: "#{@player_character.name} is now adveventuring in #{@campaign.title}"
      else
        redirect_to campaign_path(@campaign), alert: "Could not add character to campaign"
      end
    else
      redirect_to campaign_path(@campaign), alert: "This character can not join this campaign"
    end
  end

  def remove_pc
    debugger
    @campaign = Campaign.find(params[:id])
    @player_character = Character.find(params[:character])
    if @player_character.status == 'adventuring' && @campaign.player_characters.include?(@player_character)
      # add character to formerchacter association
      @campaign.player_characters -= [@player_character]
      if @campaign.save
        @player_character.stop!
        @player_character.current_campaign = nil
        @player_character.save
        @campaign.characters.where(player_character_id: @player_character.id).first.destroy
        debugger
        redirect_to campaign_path(@campaign), notice: "#{@character.name} left the campaign: #{@campaign.title}"
      else
        redirect_to campaign_path(@campaign), alert: "Could not remove character from campaign"
      end
    else
      redirect_to campaign_path(@campaign), alert: "This character can not leave this campaign"
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :link, :intro, :game_id, :image, :information)
  end
end
