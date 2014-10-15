class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    debugger
    @entry = @attachment.attachable
    if @attachment.save
      redirect_to @entry, :notice => "Successfully created attachment ."
    else
      render controller: 'games', :action => 'show'
    end
  end

  def edit
    @attachment = Attachment.find(params[:id])
  end

  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update_attributes(attachment_params)
      redirect_to @attachment, :notice  => "Successfully updated attachment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @attachment.find(params[:id])
    @attachment.destroy
    redirect_to attachment_url, :notice => "Successfully destroyed hment."
  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  private

  def attachment_params
    params.require(:attachment).permit(:title, :resource_id, :attachable_type, :attachable_id, resource_attributes: [ :file ])
  end
end

