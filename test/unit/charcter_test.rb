require 'test_helper'

class CharcterTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Charcter.new.valid?
  end
end
