# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  resource_id     :integer
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class  Attachment < ActiveRecord::Base

  belongs_to :entity, polymorphic: true

   has_attached_file :file,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }

  validates :file, :attachment_presence => true
  do_not_validate_attachment_file_type :file


end
