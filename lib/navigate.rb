module Navigate
  EARTH_RADIUS = { 'KM' => 6371.009, 'MI' => 3958.761, 'NM' => 3440.070, 'YD' => 6967420, 'FT' => 20902260 }
end

path = File.expand_path(File.dirname(__FILE__))
$:.unshift path unless $:.include?(path)
require 'navigate/conversions'
require 'navigate/position'
require 'navigate/functions'
