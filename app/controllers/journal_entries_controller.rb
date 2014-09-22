class JournalEntriesController < ApplicationController
  load_and_authorize_resource param_method: :journal_entry_params

  def index
    @journal_entries = JournalEntry.all
  end

  def new
    @journal_entry = JournalEntry.new
  end

  def create
    @journal_entry = JournalEntry.new(journal_entry_params)
    if @journal_entry.save
      if request.referrer.match('journal_entries')
        redirect_to @journal_entry, :notice  => "Successfully add journal_entry."
      else
        redirect_to request.referrer, :notice  => "Successfully add journal_entry."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @journal_entry = JournalEntry.find(params[:id])
  end

  def update
    @journal_entry = JournalEntry.find(params[:id])
    if @journal_entry.update_attributes(journal_entry_params)
      redirect_to @journal_entry, :notice  => "Successfully updated journal entry."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.destroy
    redirect_to journal_entry_url, :notice => "Successfully destroyed Journal Entry."
  end

  def show
    @journal_entry = JournalEntry.find(params[:id])
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:content, :date, :player_character_id)
  end
end
