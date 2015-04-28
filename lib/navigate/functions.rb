module Navigate
  class Functions
    include Conversions

    def self.distance_between(*args)
      new(*args).distance_between
    end

    def self.bearing(*args)
      new(*args).bearing
    end

    def self.destination(*args)
      new(*args).destination
    end

    def initialize(pos1, pos2, options = {})
      @lat1 = to_radians pos1.latitude
      @lat2 = to_radians pos2.latitude
      @lon1 = to_radians pos1.longitude
      @lon2 = to_radians pos2.longitude
      @brng = options.delete(:brng) { 90.0 }
      @distance = options.delete(:distance) { 100.0 }
      @radius = EARTH_RADIUS[options.delete(:unit) || 'KM']
    end

    def distance_between
      Math::acos(
        Math::sin(lat1) * Math::sin(lat2) +
        Math::cos(lat1) * Math::cos(lat2) *
        Math::cos(lon2 - lon1)
      ) * radius
    end

    def bearing
      dLon = lon2-lon1

      y = Math::sin(dLon) * Math::cos(lat2)
      x = Math::cos(lat1) * Math::sin(lat2) -
          Math::sin(lat1) * Math::cos(lat2) * Math::cos(dLon)

      to_bearing Math::atan2(y, x)
    end

    def destination
      new_lat = Math::asin(
              Math::sin(lat1) * Math::cos(distance / radius) +
              Math::cos(lat1) * Math::sin(distance / radius) *
              Math::cos(brng)
            )

      new_lon = lon1 + Math::atan2(
                      Math::sin(brng) * Math::sin(distance / radius) * Math::cos(lat1),
                      Math::cos(distance / radius) - Math::sin(lat1) * Math::sin(new_lat)
                    )

      new_lon = (new_lon + Math::PI) % (2 * Math::PI) - Math::PI

      Position.new to_degrees(new_lat), to_degrees(new_lon)
    end

    attr_reader :lat1, :lat2, :lon1, :lon2, :radius, :distance, :brng
  end
end
