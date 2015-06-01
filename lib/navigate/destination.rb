module Navigate
  private

  class Destination
    def self.calculate(*args)
      new(*args).calculate
    end

    def initialize(position, options = {})
      valid_args?(position, options[:bearing])

      @latitude = position.latitude.to_radians
      @longitude = position.longitude.to_radians
      @radius = EARTH_RADIUS[options[:radius_unit] || 'KM']
      @bearing = options[:bearing] || 90.0
      @distance = options[:distance] || 100.0
    end

    def calculate
      new_lat = Math::asin(
              Math::sin(latitude) * Math::cos(distance / radius) +
              Math::cos(latitude) * Math::sin(distance / radius) *
              Math::cos(bearing)
            )

      new_lon = longitude + Math::atan2(
                      Math::sin(bearing) * Math::sin(distance / radius) * Math::cos(latitude),
                      Math::cos(distance / radius) - Math::sin(latitude) * Math::sin(new_lat)
                    )

      new_lon = (new_lon + Math::PI) % (2 * Math::PI) - Math::PI

      Position.new new_lat.to_degrees, new_lon.to_degrees
    end

    private

    attr_reader :latitude, :longitude, :radius, :bearing, :distance

    def valid_args?(position, bearing)
      raise 'First arg, must be a Navigate::Position instance' unless position.is_a?(Navigate::Position)
      raise 'Bearing must be between 0.0 and 360.0' if bearing && !(0.0..360.0).include?(bearing)
    end
  end
end
