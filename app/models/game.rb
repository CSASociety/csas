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
  has_many :attachments, as: :entity

  belongs_to :user

  has_many :campaigns

  #belongs_to :image, class_name: "Resource"
     has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }

  validates_attachment_content_type :image, :content_type => /\Aimage/

  validates :title, length: { minimum: 3 }, uniqueness: true, presence: true
end

