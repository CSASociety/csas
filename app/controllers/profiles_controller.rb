class ProfilesController < ApplicationController
  load_and_authorize_resource param_method: :game_params
  def index
    @profiles = Profile.all
  end

  def edit
    @profile = Profile.find(game_params)
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to profiles_url, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @possible_images = Resource.where('file_content_type like ?', '%image%')
  end

  def game_params
    params.require(:profile).permit()
  end

end
