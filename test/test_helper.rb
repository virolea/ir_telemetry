# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"

require "ir_telemetry"

require_relative "support/test_macro"

Minitest::Test.class_eval do
  extend TestMacro
end
