class EmailsController < ApplicationController
  load_and_authorize_resource param_method: :email_params

  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)
    #@email.user = current_user if current_user.present?
    if @email.save
      redirect_to @email, :notice => "Successfully created email."
    else
      flash['alert'] = "Unable to save. See errors below"
      render :action => 'new'
    end
  end

  def edit
    @email = Email.find(params[:id])
    @attachment = Attachment.new()
  end

  def update
    @email = Email.find(params[:id])
    if @email.update_attributes(email_params)
      redirect_to @email, :notice  => "Successfully updated email."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_url, :notice => "Successfully destroyed email."
  end

  def show
    @email = Email.find(params[:id])
  end

  private

  def email_params
    params.require(:email).permit(:title, :description, :link, :image)
  end
end

