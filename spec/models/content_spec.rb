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

require 'rails_helper'

RSpec.describe Content, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
