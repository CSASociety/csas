class PlayerCharacter < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :character_template

  validates :character_template, :presence => true, :uniqueness => {:scope => :campaign}

  include AASM

  aasm :column => 'status' do
    state :adventuring, inital: true
    state :retired
    state :dead
    state :missing

    event :join do
      transitions from: [:retired, :dead, :missing], to: :adventuring
    end

    event :retire do
      transitions from: [:adventuring, :missing], to: :retired
    end

    event :kill do
      transitions from: [:adventuring, :missing], to: :dead
    end

    event :lose do
      transitions from: :adventuring, to: :missing
    end

  end


 # def name
 #   self.character.name
 # end
end
