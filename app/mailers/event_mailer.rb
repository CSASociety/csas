class EventMailer < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def reminder(event)
    @event = event
    @start = event.start_at
    @end = event.stop_at
    @location = event.location
    user_emails = []
    @event.campaigns.each do |campaign|
      campaign.players.each do |player|
        user_emails << player.user.email if player.user.email.present?
      end
    end
    subject = "Event starting on #{@start}"
    @map_link = "http://maps.google.com/?q=#{@location.tr(' ', '%20')}"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    if mail(to: (user_emails.empty? ? user_emails : 'nejohannsen@gmail.com'), subject: subject)
      @event.reminder_sent = true
      @event.save
    end
  end
end
