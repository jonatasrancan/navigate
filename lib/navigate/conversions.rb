module Navigate
  module Conversions
    # degrees to radians
    def to_radians(degrees)
      degrees * Math::PI / 180.0
    end

    # radians to bearing
    def to_bearing(radians)
      (to_degrees(radians) + 360.0) % 360.0
    end

    # radians to degree
    def to_degrees(radians)
      radians * 180 / Math::PI
    end
  end
end
