require 'rails_helper'

RSpec.describe Game, :type => :model do
  it "should save an oject with valid attributes" do
    resource = build(:resource)
    resource.save!
    expect(Resource.first).to eq(resource)
  end
end
