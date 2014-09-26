class AssistantsController < ApplicationController
  def index
    @assistants = Assistant.all
  end

  def show
    @assistant = Assistant.find(params[:id])
  end

  def new
    @assistant = Assistant.new
  end

  def create
    @assistant = Assistant.new(assistant_params)
    return_to = Rails.application.routes.recognize_path(request.referrer)[:controller] == "players" ? @player : request.referrer
    if @assistant.save
      redirect_to return_to, :notice => "Successfully created assistant."
    else
      render :action => 'new'
    end
  end

  def edit
    @assistant = Assistant.find(params[:id])
  end

  def update
    @assistant = Assistant.find(params[:id])
    if @assistant.update_attributes(assistant_params)
      redirect_to @assistant, :notice  => "Successfully updated assistant."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @assistant = Assistant.find(params[:id])
    @assistant.destroy
    redirect_to assistants_url, :notice => "Successfully destroyed assistant."
  end

  private

  def assistant_params
    params.require(:assistant).permit(:campaign_id, :user_id)
  end
end
