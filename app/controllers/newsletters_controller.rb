class NewslettersController < ApplicationController
  load_and_authorize_resource params_method: :newsletter_params
  
  def index
    @newsletters = Newsletter.all
    @current_newsletter = Newsletter.last
  end

  def new
    @newsletter = Newsletter.new()
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      redirect_to newsletters_path, :notice => "Successfully uploaded Newsletter"
    else
      render :action => 'new'
    end
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  private
  
  def newsletter_params
    params.require(:newsletter).permit(:file)
  end
end
