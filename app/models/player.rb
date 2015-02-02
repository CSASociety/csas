# == Schema Information
#
# Table name: players
#
#  id                 :integer          not null, primary key
#  campaign_id        :integer
#  user_id            :integer
#  aasm_state         :string(255)
#  status_approver_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
  belongs_to :status_approver, class_name: 'User'

  has_many :player_characters

  validate :user, presence: true
  validate :status_approver, presence: true

  delegate :display_name, to: :user

  include AASM

  alias_attribute :status, :aasm_state

  aasm do
    state :pending, :initial => true
    state :active
    state :removed
    state :denied

    event :activate do
      transitions :from => :pending, :to => :active,  :guard => :check_auth_active, :on_transition => Proc.new {|obj, *args| obj.set_status_approver(*args) }
    end

    event :deny do
      transitions :from => :pending, :to => :denied,  :guard => :check_auth_denied, :on_transition => Proc.new {|obj, *args| obj.set_status_approver(*args) }
    end

    event :remove do
      transitions :from => :active, :to => :removed, :on_transition => Proc.new {|obj, *args| obj.set_status_approver(*args) }
    end

    event :request do
      transitions :from => [:denied, :removed], :to => :pending,  :guard => :check_auth_pending, :on_transition => Proc.new {|obj, *args| obj.set_status_approver(*args) }
    end
  end

  def check_auth_active(user)
    if user == self.campaign.gm
      return true
    else
      return (self.status_approver_id.nil? || self.status_approver != user) ? true : false
    end
  end

  def check_auth_denied(user)
    if user == self.campaign.gm
      return true
    else
      return (self.status_approver_id.nil? || self.status_approver != user) ? true : false
    end
  end

  def check_auth_pending(user)
    if user == self.campaign.gm
      return true
    else
      return (self.status_approver_id.nil? || self.status_approver == user) ? true : false
    end
  end

  def set_status_approver(user)
    self.status_approver = user
  end
end
