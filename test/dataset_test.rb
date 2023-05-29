# frozen_string_literal: true

require "test_helper"

class DatasetTest < Minitest::Test
  def setup
    file = IRTelemetry::IBTFile.new("test/fixtures/files/clio.ibt")
    @dataset = IRTelemetry::Dataset.new(file)
  end

  test "setting variables" do
    assert_equal @dataset.variables["SessionTime"].desc, "Seconds since session start"
  end

  test "accessing a data point at a given index" do
    data_point = @dataset[12450]

    assert_equal 5139.22, data_point["RPM"].ceil(2)
  end

  test "iterating over the dataset" do
    i = 0
    session_times = []

    @dataset.each do |data_point|
      break if i == 9

      session_times << data_point["SessionTime"].ceil(2)
      i += 1
    end

    assert_equal session_times, [
      5.79,
      5.81,
      5.82,
      5.84,
      5.86,
      5.87,
      5.89,
      5.91,
      5.92
    ]
  end
end
