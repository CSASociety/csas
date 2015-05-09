# == Schema Information
#
# Table name: characters
#
#  id                  :integer          not null, primary key
#  player              :string(255)
#  name                :string(255)
#  bio                 :text
#  gm_bio              :text
#  status              :string(255)
#  image_id            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  caste               :string(255)
#  user_id             :integer
#  current_campaign_id :integer
#

class Character < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :entity 
  belongs_to :user
  belongs_to :current_campaign, class_name: :Campaign

  belongs_to :image, class_name: "Resource"
  has_and_belongs_to_many :campaigns


  alias_attribute :title, :name


  include AASM

  aasm :column => 'status' do
    state :resting, inital: true
    state :adventuring
    state :retired
    state :dead
    state :missing

    event :begin do
      transitions from: [:retired, :dead, :missing, :resting], to: :adventuring
    end

    event :retire do
      transitions from: :resting, to: :retired
    end

    event :kill do
      transitions from: [:adventuring, :missing], to: :dead
    end

    event :lose do
      transitions from: :adventuring, to: :missing
    end

    event :stop do
      transitions from: :adventuring, to: :resting
    end

    event :find do
      transitions from: :missing, to: :adventuring
    end

    event :resurrection do
      transitions from: :dead, to: :adventuring
    end

    event :reactivate do
      transitions from: :retired, to: :adventuring
    end

  end

end
