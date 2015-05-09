class GamesController < ApplicationController
  load_and_authorize_resource param_method: :game_params

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user if current_user.present?

    if @game.save
      redirect_to @game, :notice => "Successfully created game."
    else
      flash['alert'] = "Unable to save. See errors below"
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
    @attachment = Attachment.new()
  end

  def update
    @game = Game.find(params[:id])
    params["game"] = params["game"].except("image_id") if params["game"]["image_id"].blank?
    if @game.update_attributes(game_params)
      redirect_to @game, :notice  => "Successfully updated game."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_url, :notice => "Successfully destroyed game."
  end

  def show
    @game = Game.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @game.attachments
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :link, :image)
  end
end
