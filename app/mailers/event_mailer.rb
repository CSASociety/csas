class EventMailer < ActionMailer::Base
  default from: "donotreply@vaultofholding.com"

  def reminder(event)
    @event = event
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
      @sent_email = SentEmail.new(subject: subject, body: render_to_string)
      #Rails.logger.debug(@sent_email.body)
      users.each do |user|
        @sent_email.users << user
      end
      users.each do |user|
        @sent_email.users << user unless @sent_email.users.include?(user)
      end
      @sent_email.events << event
      @event.campaigns.each do |camp|
        @sent_email.campaigns << camp
      end
      @sent_email.save

    end
  end
end
