class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
  belongs_to :status_approver, class_name: 'User'

  validate :user, presence: true
  validate :status_approver, presence: true

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
    return (self.status_approver_id.nil? || self.status_approver != user) ? true : false
  end

  def check_auth_denied(user)
    return (self.status_approver_id.nil? || self.status_approver != user) ? true : false
  end

  def check_auth_pending(user)
    return (self.status_approver_id.nil? || self.status_approver == user) ? true : false
  end

  def set_status_approver(user)
    self.status_approver = user
  end
end
