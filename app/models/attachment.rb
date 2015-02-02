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

  belongs_to :resource
  belongs_to :attachable, polymorphic: true

  accepts_nested_attributes_for :resource

end
