module Navigate
  EARTH_RADIUS = { 'KM' => 6371.009, 'MI' => 3958.761, 'NM' => 3440.070, 'YD' => 6967420, 'FT' => 20902260 }

  def self.distance_between(position1, position2, radius_unit = 'KM')
    DistanceBetween.calculate(position1, position2, radius_unit)
  end

  def self.bearing(position1, position2)
    Bearing.calculate(position1, position2)
  end

  def self.destination(position, options = {})
    Destination.calculate(position, options)
  end
end

path = File.expand_path(File.dirname(__FILE__))
$:.unshift path unless $:.include?(path)
require 'navigate/conversions'
require 'navigate/position'
require 'navigate/bearing'
require 'navigate/distance_between'
require 'navigate/destination'
