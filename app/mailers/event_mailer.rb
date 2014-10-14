class EventMailer < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def reminder(event)
    @event = event
    @start = event.start_at
    @end = event.stop_at
    @location = event.location
    subject = "Event starting on #{@start}"
    @map_link = "http://maps.google.com/?q=#{@location}"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    if mail(to: "nejohannsen@gmail.com", subject: subject)
      @event.reminder_sent = true
      @event.save
    end
  end
end
