# frozen_string_literal: true

require "test_helper"

class TestIRTelemetry < ActiveSupport::TestCase
  test "version number" do
    refute_nil ::IRTelemetry::VERSION
    assert_equal "0.1.0", ::IRTelemetry::VERSION
  end
end
