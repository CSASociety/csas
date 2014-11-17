class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    #If there is a campaign attach it to new event.

    if @event.save
      unless params[:event][:campaign].nil?
        @event.campaigns << Campaign.find(params[:event][:campaign])
        delay = EventMailer.delay(run_at: (@event.start_at - 24.hours)).reminder(@event) if @event.valid?
        @event.reminder = delay.id if delay.present?
        @event.save
      end
      if request.referrer.match('events')
        redirect_to @event, :notice  => "Successfully created event."
      else
        redirect_to request.referrer, :notice  => "Successfully created event."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end

  def attach_campaign
    @event = Event.find(params[:id])
    @event.campaigns << Campaign.find(params[:event][:campaigns])
    if @event.save
      delay = EventMailer.delay(run_at: (@event.start_at - 24.hours)).reminder(@event) if @event.reminder.nil?
      @event.reminder = delay.id
      @event.save
      redirect_to @event, :notice => "Successfully added campaign to event"
    end
  end

  private

  def event_params
    params.required(:event).permit(:start_at, :stop_at, :host_id, :location)
  end
end
