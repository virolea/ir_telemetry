[![CI](https://github.com/virolea/ir_telemetry/actions/workflows/ci.yml/badge.svg)](https://github.com/virolea/ir_telemetry/actions/workflows/ci.yml)

# iRacing Telemetry

Parse and browse iRacing telemetry files with Ruby.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ir_telemetry

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ir_telemetry

## Usage

### Quick start

```ruby
ibt_filepath = "/path/to/telemetry/file.ibt"

IRTelemetry::IBTFile.open(ibt_filepath) do |file|
  # access session information hash 
  session_info = file.session_info  
  session_info['WeekendInfo']['TrackName'] # => e.g. jerez gp
  
  # access telemetry data
  file.dataset.each do |data_point|
    data_point["Speed"] # => e.g. 2432.65
    data_point["Lap"] # => 4
  end
end
```

The above code is a shorthand for: 

```ruby
ibt_filepath = "/path/to/telemetry/file.ibt"

ibt_file = IRTelemetry::IBTFile.new(ibt_filepath)

session_info = ibt_file.session_info
session_info["WeekendInfo"""]["'"TrackName"] # => e.g. jerez gp

ibt_file.dataset.each do |data_point|
  data_point["Speed"] # => e.g. 2432.65
  data_point["Lap"] # => 4
end

# close the io stream
ibt_file.close
```

### Session information

The session information is accessible through the `IBTFile` object instance. It is a Hash loaded from the session YAML which schema can be found in the Appendix B of the [telemetry docs](docs/telemetry_11_23_15.pdf).

```ruby
ibt_filepath = "/path/to/telemetry/file.ibt"

ibt_file = IRTelemetry::IBTFile.new(ibt_filepath)

# Session info is a plain Ruby Hash.
session_info = ibt_file.session_info
session_info["WeekendInfo"]["TrackName"]
```

### Telemetry data

The telemetry data is accessible through the `IBTFile` object instance. It is a `Dataset` object which is an `Enumerable` of `DataPoint` objects. You can then access telemetry variables on the datapoint by calling `[]` on it. For a complete list of available variables, see the Appendix A of the [telemetry docs](docs/telemetry_11_23_15.pdf)

```ruby
ibt_filepath = "/path/to/telemetry/file.ibt"

ibt_file = IRTelemetry::IBTFile.new(ibt_filepath)

# Telemetry data is a Dataset object
dataset = ibt_file.dataset
```

#### Iterating over available data 

```ruby
dataset.each do |data_point|
  puts data_point["Speed"]
end
```

#### Accessing a data point at a particular index 
    
```ruby
puts dataset[0]["Speed"]
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ir_telemetry.
