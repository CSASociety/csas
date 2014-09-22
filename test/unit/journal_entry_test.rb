require 'test_helper'

class JournalEntryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert JournalEntry.new.valid?
  end
end
