require 'test_helper'

class WorkdayTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Workday.new.valid?
  end
end
