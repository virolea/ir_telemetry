# frozen_string_literal: true

require "test_helper"

class DataPointTest < Minitest::Test
  def setup
    buffer = File.open("test/fixtures/data_point_buffer.bin", "rb").read
    dataset = IRTelemetry::IBTFile.new( "test/fixtures/files/clio.ibt").dataset
    @data_point = IRTelemetry::DataPoint.new(buffer, dataset)
  end

  test "accessing variables" do
    assert_equal 5139.22, @data_point["RPM"].ceil(2)
    assert_equal 3, @data_point["Gear"]
  end
end
