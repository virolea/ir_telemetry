# frozen_string_literal: true

require "test_helper"

class TestIRTelemetry < Minitest::Test
  test "version number" do
    refute_nil ::IRTelemetry::VERSION
    assert_equal "0.2.0", ::IRTelemetry::VERSION
  end
end
