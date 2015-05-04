class NewslettersController < ApplicationController
  load_and_authorize_resource params_method: :newsletter_params
  
  def index
    @newsletters = Newsletter.all.order('month desc')
    @current_newsletter = @newsletters.first
  end

  def new
    @newsletter = Newsletter.new()
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    @newsletter.month = DateTime.strptime(newsletter_params['month'], '%Y-%m') if newsletter_params['month'].present?
    if @newsletter.save
      redirect_to newsletters_path, :notice => "Successfully uploaded Newsletter"
    else
      render :action => 'new'
    end
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    @newsletter.assign_attributes(newsletter_params)
    @newsletter.month = DateTime.strptime(newsletter_params['month'], '%Y-%m') if newsletter_params['month'].present?
    if @newsletter.save
      redirect_to newsletters_path, :notice => "Successfully updated Newsletter"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy
    redirect_to newsletters_path, notice: "Successfully destroyed newsletter"
  end

  private
  
  def newsletter_params
    params.require(:newsletter).permit(:file, :month)
  end
end
