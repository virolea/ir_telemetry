# frozen_string_literal: true

require "zeitwerk"
require "bindata"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "ir_telemetry" => "IRTelemetry"
loader.inflector.inflect "ibt_file" => "IBTFile"
loader.inflector.inflect "irsdk_header" => "IRSDKHeader"
loader.inflector.inflect "irsdk_var_header" => "IRSDKVarHeader"
loader.setup

module IRTelemetry
  class Error < StandardError; end
end
