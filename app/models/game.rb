# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  link        :string(255)
#  image_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Game < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments
  belongs_to :user

  has_many :campaigns

  belongs_to :image, class_name: "Resource"

  validates :title, length: { minimum: 3 }, uniqueness: true, presence: true
end

