# frozen_string_literal: true

module IRTelemetry
  class Telemetry
    extend Forwardable

    def_delegators :@file, :header, :io

    def initialize(file)
      @file = file
    end

    def dataset
      @dataset ||= Dataset.new(@file)
    end
  end
end
