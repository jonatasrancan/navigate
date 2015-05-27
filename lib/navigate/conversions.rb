class Float
  # degrees to radians
  def to_radians
    self * Math::PI / 180.0
  end

  # radians to bearing
  def to_bearing
    (self.to_degrees + 360.0) % 360.0
  end

  # radians to degree
  def to_degrees
    self * 180 / Math::PI
  end
end
