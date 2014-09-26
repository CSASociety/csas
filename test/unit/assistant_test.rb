require 'test_helper'

class AssistantTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Assistant.new.valid?
  end
end
