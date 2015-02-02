# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  user_id           :integer
#

class Resource < ActiveRecord::Base

  has_many :attachments

  has_attached_file :file,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }

  validates :file, :attachment_presence => true

  has_many :game_images, class_name: "Game", foreign_key: "image_id"
  belongs_to :user

  do_not_validate_attachment_file_type :file
end
