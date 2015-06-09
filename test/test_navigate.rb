require 'helper'

describe Navigate do
  before do
    @position1 = Navigate::Position.new(90.0, 120.0)
    @position2 = Navigate::Position.new(80.0, 120.0)
  end

  describe "#distance_between" do
    it 'calculates the distance between 2 positions in kilometers' do
      Navigate::distance_between(@position1, @position1).must_equal 0
    end

    it 'calculates the distance between 2 positions in kilometers' do
      km = Navigate::distance_between(@position1, @position2).round(2)

      km.must_equal 1111.95
    end

    it 'calculates the distance between 2 positions in nautic miles' do
      nm = Navigate::distance_between(@position1, @position2, 'NM').round(2)

      nm.must_equal 600.41
    end

    it "raise exception when first arg isn't a Navigate::Position" do
      exception = assert_raises(RuntimeError) { Navigate::distance_between('wrong type', 90.0) }

      assert_match /First arg, must be a Navigate::Position instance/, exception.message
    end

    it "raise exception when second arg isn't a Navigate::Position" do
      exception = assert_raises(RuntimeError) { Navigate::distance_between(@position1, 500) }

      assert_match /Second arg, must be a Navigate::Position instance/, exception.message
    end
  end

  describe '#bearing' do
    it 'calculates the bearing between 2 positions' do
      bearing = Navigate::bearing(@position1, @position2)

      bearing.must_equal 180
    end

    it 'calculates the bearing between 2 positions' do
      bearing = Navigate::bearing(@position2, @position1)

      bearing.must_equal 0
    end

    it "raise exception when first arg isn't a Navigate::Position" do
      exception = assert_raises(RuntimeError) { Navigate::bearing('wrong type', 90.0) }

      assert_match /First arg, must be a Navigate::Position instance/, exception.message
    end

    it "raise exception when second arg isn't a Navigate::Position" do
      exception = assert_raises(RuntimeError) { Navigate::bearing(@position1, 500) }

      assert_match /Second arg, must be a Navigate::Position instance/, exception.message
    end
  end

  describe '#destination' do
    it 'returns a final position, using default radius unit, distance and bearing' do
      destination = Navigate::destination(@position1)

      assert_kind_of Navigate::Position, destination

      destination.longitude.round(2).must_equal -150.0
      destination.latitude.round(2).must_equal 89.1
    end

    it 'returns a final positions, passing custom radius unit, distance and bearing' do
      destination = Navigate::destination(@position1, bearing: 270, radius_unit: 'NM', distance: 200)

      destination.longitude.round(2).must_equal 30.0
      destination.latitude.round(2).must_equal 86.67
    end

    it "raise exception when first arg isn't a Navigate::Position" do
      exception = assert_raises(RuntimeError) { Navigate::destination('wrong type') }

      assert_match /First arg, must be a Navigate::Position instance/, exception.message
    end

    it "raise exception when bearing is out of range" do
      exception = assert_raises(RuntimeError) { Navigate::destination(@position1, bearing: 500) }

      assert_match /Bearing must be between 0.0 and 360.0/, exception.message
    end
  end
end
