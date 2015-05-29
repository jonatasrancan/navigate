[![Build Status](https://travis-ci.org/jonatasrancan/navigate.svg?branch=master)](https://travis-ci.org/jonatasrancan/navigate)
## navigate

A simple gem with some functions, to calculate the distance, bearing between two positions or
the next position considering a initial position, distance and bearing.

## Usage

In your Gemfile

```ruby
gem 'navigate'
```
or just install
```ruby
gem install navigate
```

###Distance between 2 positions
```ruby
# the firs param is the latitude, second is the longitude
position1 = Navigate::Position.new(80.0, 120.0)
position2 = Navigate::Position.new(90.0, 45.0)

Navigate::distance_between(position1, position2)
# => 1111.9508372419155
```
By default the function will return the distane in kilometers

It has a third optional param, to define the unit of the return

```ruby
Navigate::distance_between(position1, position2, 'NM')
# => 600.4054799908141
```
Available units
```ruby
{ 'KM', 'MI', 'NM', 'YD', 'FT' }
```

### Bearing between two positions
```ruby
position1 = Navigate::Position.new(-90.0, 180.0)
position2 = Navigate::Position.new(90.0, 45.0)

Navigate::bearing(position1, position2)
# => 292.5
```

### Return a new position based on a initial position, bearing and distance
```ruby
position1 = Navigate::Position.new(-90.0, 180.0)

Navigate::bearing(position1)
# => #<Navigate::Position:0x00000003edc7b0 @latitude=-89.10067966450693, @longitude=-90.0>
```
By default the function will use a bearing = 90.0, distance = 100 KM

It receive a hash of options to pass the bearing, distance and the unit of the distance

```ruby
Navigate::bearing(position1, bearing: 180.0, distance: 150, radius_unit: 'FT')
# => #<Navigate::Position:0x00000003e9b198 @latitude=-90.0, @longitude=-180.0> 
```

Contributing to navigate
------------------------ 
 Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
 
 Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
 
 Fork the project.
 
 Start a feature/bugfix branch.
 
 Commit and push until you are happy with your contribution.
 
 Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
 
 Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

License
-------
The navigate gem is distributed under the MIT License.

