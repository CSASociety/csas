class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign
  belongs_to :status_approver, class_name: 'User'

  validate :user, presence: true
  validate :status_approver, presence: true

  #include AASM

  #aasm do
  #  state :sleeping, :initial => true
  #  state :running
  #  state :cleaning

  #  event :run do
  #    transitions :from => :sleeping, :to => :running
  #  end

  #  event :clean do
  #    transitions :from => :running, :to => :cleaning
  #  end

  #  event :sleep do
  #    transitions :from => [:running, :cleaning], :to => :sleeping
  #  end
  #end


  def status
    return 'Pending' if self.pending
    return 'Active' if self.active
    return 'Removed' if self.removed
    return 'Denied' if self.denied
  end

  def status=(val)
    self.clear_status
    self.pending = true if val == 'Pending'
    self.active = true if val == 'Active'
    self.denied = true if val == 'Denied'
    self.removed = true if val == 'Removed'
  end


  def clear_status
    self.pending = false
    self.active = false
    self.denied = false
    self.removed = false
  end

end
