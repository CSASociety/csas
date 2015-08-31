class SentEmailsController < ApplicationController
  load_and_authorize_resource param_method: :sent_email_params

  def index
    @sent_emails = SentEmail.all
  end

  #def new
  #  @sent_email = SentEmail.new
  #end

  def create
    @sent_email = SentEmail.new(sent_email_params)
    @sent_email.user = current_user if current_user.present?

    if @sent_email.save
      redirect_to @sent_email, :notice => "Successfully created sent_email."
    else
      flash['alert'] = "Unable to save. See errors below"
      render :action => 'new'
    end
  end

  #def edit
  #  @sent_email = SentEmail.find(params[:id])
  #  @attachment = Attachment.new()
  #end

  #def update
  #  @sent_email = SentEmail.find(params[:id])
  #  params["sent_email"] = params["sent_email"].except("image_id") if params["sent_email"]["image_id"].blank?
  #  if @sent_email.update_attributes(sent_email_params)
  #    redirect_to @sent_email, :notice  => "Successfully updated sent_email."
  #  else
  #    render :action => 'edit'
  #  end
  #end

  #def destroy
  #  @sent_email = SentEmail.find(params[:id])
  #  @sent_email.destroy
  #  redirect_to sent_emails_url, :notice => "Successfully destroyed sent_email."
  #end

  def show
    @sent_email = SentEmail.find(params[:id])
    @new_attachment = Attachment.new
    @attachments = @sent_email.attachments
  end

  private

  def sent_email_params
    params.require(:sent_email).permit(:title, :description, :link, :image)
  end
end

