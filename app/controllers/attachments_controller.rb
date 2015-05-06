class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    @entry = @attachment.entity
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
      redirect_to @attachment.entity, :notice  => "Successfully updated attachment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    attachment = Attachment.find(params[:id])
    item = attachment.entity
    attachment.destroy
    redirect_to item, :notice => "Successfully destroyed hment."
  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  private

  def attachment_params
    params.require(:attachment).permit(:title, :entity_id, :entity_type, :file )
  end
end

