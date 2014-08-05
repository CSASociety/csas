class  Attachment < ActiveRecord::Base

  belongs_to :resource
  belongs_to :attachable, polymorphic: true

end
