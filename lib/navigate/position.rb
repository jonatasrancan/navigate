module Navigate
  class Position
    attr_accessor :latitude, :longitude

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude
    end
  end
end
