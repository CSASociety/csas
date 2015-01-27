# == Schema Information
#
# Table name: newsletters
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

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
