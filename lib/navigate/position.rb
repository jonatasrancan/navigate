module Navigate
  class Position
    attr_accessor :latitude, :longitude

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude

      valid?
    end

    private

    def valid_latitude?
      raise 'Latitude must be between -90.0 and 90.0' unless (-90.0..90.0).include? latitude
    end

    def valid_longitude?
      raise 'Longitude must be between -180.0 and 180.0' unless (-180.0..180.0).include? longitude
    end

    def valid?
      valid_latitude?
      valid_longitude?

      true
    end
  end
end
