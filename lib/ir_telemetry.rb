# frozen_string_literal: true

require "zeitwerk"
require "bindata"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "ir_telemetry" => "IRTelemetry"
loader.inflector.inflect "irsdk_header" => "IRSDKHeader"
loader.setup

module IRTelemetry
  class Error < StandardError; end
end
