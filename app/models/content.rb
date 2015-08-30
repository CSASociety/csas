# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

class Content < ActiveRecord::Base
end
