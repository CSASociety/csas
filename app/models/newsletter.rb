class Newsletter < ActiveRecord::Base
  has_attached_file :file,
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }   
  validates :file, :attachment_presence => true

  do_not_validate_attachment_file_type :file
end
