class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to @resource, :notice => "Successfully created resource."
    else
      render :action => 'new'
    end
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      redirect_to @resource, :notice  => "Successfully updated resource."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to resources_url, :notice => "Successfully destroyed resource."
  end

  private

  def resource_params
    params.require(:resource).permit(:file)
  end
end
