module Navigate
  EARTH_RADIUS = { 'KM' => 6371.009, 'MI' => 3958.761, 'NM' => 3440.070, 'YD' => 6967420, 'FT' => 20902260 }

  def self.distance_between(position1, position2, radius_unit = 'KM')
    Math::acos(
      Math::sin(position1.latitude.to_radians) * Math::sin(position2.latitude.to_radians) +
      Math::cos(position1.latitude.to_radians) * Math::cos(position2.latitude.to_radians) *
      Math::cos((position2.longitude - position1.longitude).to_radians)
    ) * EARTH_RADIUS[radius_unit]
  end

  def self.bearing(position1, position2)
    dLon = (position2.longitude - position1.longitude).to_radians

    y = Math::sin(dLon) * Math::cos(position2.latitude.to_radians)
    x = Math::cos(position1.latitude.to_radians) * Math::sin(position2.latitude.to_radians) -
        Math::sin(position1.latitude.to_radians) * Math::cos(position2.latitude.to_radians) * Math::cos(dLon)

    Math::atan2(y, x).to_bearing
  end

  def self.destination(position, options = {})
    radius = EARTH_RADIUS[options[:radius_unit] || 'KM']
    distance = options[:distance] || 100.0
    brng = options[:bearing] || 90.0

    new_lat = Math::asin(
            Math::sin(position.latitude.to_radians) * Math::cos(distance / radius) +
            Math::cos(position.latitude.to_radians) * Math::sin(distance / radius) *
            Math::cos(brng)
          )

    new_lon = position.longitude.to_radians + Math::atan2(
                    Math::sin(brng) * Math::sin(distance / radius) * Math::cos(position.latitude.to_radians),
                    Math::cos(distance / radius) - Math::sin(position.latitude.to_radians) * Math::sin(new_lat)
                  )

    new_lon = (new_lon + Math::PI) % (2 * Math::PI) - Math::PI

    Position.new new_lat.to_degrees, new_lon.to_degrees
  end
end

path = File.expand_path(File.dirname(__FILE__))
$:.unshift path unless $:.include?(path)
require 'navigate/conversions'
require 'navigate/position'
