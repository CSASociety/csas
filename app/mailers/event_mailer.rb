class EventMailer < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def reminder(event)
    @event = event
    @start = event.start_at
    @end = event.stop_at
    @location = event.location
    @map_link = "http://maps.google.com/?q=#{@location}"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    mail(to: event.campaign.gm.email, subject: subject)
  end
end
