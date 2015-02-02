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

require 'rails_helper'

RSpec.describe Game, :type => :model do
  it "should save an oject with valid attributes" do
    resource = build(:resource)
    resource.save!
    expect(Resource.first).to eq(resource)
  end
end
