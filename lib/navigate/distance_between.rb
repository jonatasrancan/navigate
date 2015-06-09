module Navigate
  private

  class DistanceBetween
    def self.calculate(*args)
      new(*args).calculate
    end

    def initialize(position1, position2, radius_unit)
      valid_args?(position1, position2)

      @latitude1 = position1.latitude.to_radians
      @longitude1 = position1.longitude.to_radians
      @latitude2 = position2.latitude.to_radians
      @longitude2 = position2.longitude.to_radians
      @radius_unit = EARTH_RADIUS[radius_unit || 'KM']
    end

    def calculate
      Math::acos(
        Math::sin(latitude1) * Math::sin(latitude2) +
        Math::cos(latitude1) * Math::cos(latitude2) *
        Math::cos(longitude2 - longitude1)
      ) * radius_unit
    end

    private

    attr_reader :latitude1, :latitude2, :longitude1, :longitude2, :radius_unit

    def valid_args?(position1, position2)
      raise 'First arg, must be a Navigate::Position instance' unless position1.is_a?(Navigate::Position)
      raise 'Second arg, must be a Navigate::Position instance' unless position2.is_a?(Navigate::Position)
    end
  end
end
