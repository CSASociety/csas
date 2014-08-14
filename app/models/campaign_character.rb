class CampaignCharacter < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :character

  validates :character, :presence => true, :uniqueness => {:scope => :campaign}

 # def name
 #   self.character.name
 # end
end
