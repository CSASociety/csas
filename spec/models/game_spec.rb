require 'rails_helper'

RSpec.describe Game, :type => :model do

  it "should save an objec with valid attributes" do 
    game = build(:game)
    game.save!
    debugger
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
