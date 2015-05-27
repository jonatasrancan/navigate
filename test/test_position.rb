require 'helper'

describe Navigate::Position do
  context 'validations fails' do
    it "raise an exception when latitude isn't between -90 and 90" do

      exception = assert_raises(RuntimeError) { Navigate::Position.new(200, 100) }

      assert_match /Latitude must be between -90.0 and 90.0/, exception.message
    end

    it "raise an exception when longitude isn't between -180 and 180" do

      exception = assert_raises(RuntimeError) { Navigate::Position.new(50, 200) }

      assert_match /Longitude must be between -180.0 and 180.0/, exception.message
    end
  end

  context 'validations pass' do
    it "create a new Navigate::Positions" do
      position = Navigate::Position.new(90.0, 100.0)

      assert_kind_of Navigate::Position, position
    end
  end
end
