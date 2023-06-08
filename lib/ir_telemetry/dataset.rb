# frozen_string_literal: true

module IRTelemetry
  class Dataset
    include Enumerable

    attr_reader :variables

    def initialize(io, variables, buffer_length, cursor_start)
      @io = io
      @variables = variables
      @buffer_length = buffer_length
      @cursor_start = cursor_start
    end

    def [](index)
      @io.seek(@cursor_start + index * @buffer_length)

      buffer = @io.read(@buffer_length)
      DataPoint.new(buffer, self)
    end

    def each(&block)
      start_at_the_beginning

      while (buffer = @io.read(@buffer_length))
        data_point = DataPoint.new(buffer, self)

        yield data_point if block
      end
    end

    private

    def start_at_the_beginning
      @io.seek(@cursor_start)
    end
  end
end
