# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  private    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
end
