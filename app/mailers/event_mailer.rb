class EventMailer < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def reminder(event)
    @event = Event.find(event)
    #@event = event
    @start = event.start_at
    @end = event.stop_at
    @location = event.location
    users = []
    user_emails = []
    @event.campaigns.each do |campaign|
      (users << campaign.gm) if campaign.gm.present?
      (user_emails << campaign.gm.email) if campaign.gm.email.present?
      campaign.players.each do |player|
        (users << player.user) if player.user.present?
        (user_emails << player.user.email) if player.user.email.present?
      end
    end
    subject = "Event starting on #{@start}"
    @map_link = "http://maps.google.com/?q=#{@location.tr(' ', '%20')}"
    if Rails.env == "staging" || Rails.env == "development"
      subject = subject + " - #{Rails.env}"
    end
    if mail(to: (user_emails.present? ? user_emails : 'nejohannsen@gmail.com'), subject: subject)
      @event.reminder_sent = true
      @event.save
      @email = Email.new(subject: subject, body: render_to_string)
      ##Rails.logger.debug(@email.body)
      users.each do |user|
        @email.users << user
      end
      users.each do |user|
        @email.users << user unless @email.users.include?(user)
      end
      @email.events << event
      @event.campaigns.each do |camp|
        @email.campaigns << camp
      end
      @email.save

    end
  end
end
