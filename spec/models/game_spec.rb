# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  link        :string(255)
#  image_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe Game, :type => :model do

  it "should save an objec with valid attributes" do 
    game = build(:game)
    game.save!
    expect(Game.first).to eq(game)
  end

  #Making sure I set up the database cleaner Correct
  it "should have the database cleaning after every test" do
    expect(Game.first).to be_nil
  end

  it "should require atleast 3 letters in the title" do
    game = build(:game, title: 'no')
    expect(game).to_not be_valid
  end
end
