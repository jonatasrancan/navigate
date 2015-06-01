module Navigate
  private

  class Bearing
    def self.calculate(*args)
      new(*args).calculate
    end

    def initialize(position1, position2)
      valid_args?(position1, position2)

      @latitude1 = position1.latitude.to_radians
      @longitude1 = position1.longitude.to_radians
      @latitude2 = position2.latitude.to_radians
      @longitude2 = position2.longitude.to_radians
    end

    def calculate
      dLon = longitude2 - longitude1

      y = Math::sin(dLon) * Math::cos(latitude2)
      x = Math::cos(latitude1) * Math::sin(latitude2) -
          Math::sin(latitude1) * Math::cos(latitude2) * Math::cos(dLon)

      Math::atan2(y, x).to_bearing
    end

    private

    attr_reader :latitude1, :latitude2, :longitude1, :longitude2

    def valid_args?(position1, position2)
      raise 'First arg, must be a Navigate::Position instance' unless position1.is_a?(Navigate::Position)
      raise 'Second arg, must be a Navigate::Position instance' unless position2.is_a?(Navigate::Position)
    end
  end
end
