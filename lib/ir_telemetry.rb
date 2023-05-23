# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "ir_telemetry" => "IRTelemetry"
loader.setup

module IRTelemetry
  class Error < StandardError; end
end
