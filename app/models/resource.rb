class Resource < ActiveRecord::Base
  has_attached_file :file,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }

  validates :file, :attachment_presence => true

  has_one :game_image, class_name: "Game", foreign_key: "image_id"

  do_not_validate_attachment_file_type :file
end
