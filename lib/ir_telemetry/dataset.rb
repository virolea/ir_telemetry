# frozen_string_literal: true

module IRTelemetry
  class Dataset
    extend Forwardable
    include Enumerable

    attr_reader :variables

    def_delegators :@file, :header, :io

    def initialize(file)
      @file = file
      @variables = set_variables
    end

    def [](index)
      io.seek(buffer_offset + index * buffer_length)

      buffer = io.read(buffer_length)
      DataPoint.new(buffer, self)
    end

    def each(&block)
      start_at_the_beginning

      while (buffer = io.read(buffer_length))
        data_point = DataPoint.new(buffer, self)

        yield data_point if block_given?
      end
    end

    private

    def set_variables
      io.seek(header.var_header_offset)

      var_buffer = io.read(IBTFile::IRSDK_VAR_HEADER_SIZE * header.num_vars)

      variables = {}

      (0...header.num_vars - 1).each do |i|
        irsdk_var = Headers::IRSDKVarHeader.read(
          var_buffer.byteslice(i * IBTFile::IRSDK_VAR_HEADER_SIZE, IBTFile::IRSDK_VAR_HEADER_SIZE)
        )

        variables[irsdk_var.name.to_s] = irsdk_var
      end

      variables
    end

    def start_at_the_beginning
      io.seek(buffer_offset)
    end

    def buffer_offset
      header.var_buf[0].buf_offset
    end

    def buffer_length
      header.buf_len
    end
  end
end
