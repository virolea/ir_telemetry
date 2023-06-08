# frozen_string_literal: true

module IRTelemetry
  class Telemetry
    extend Forwardable

    def_delegators :@file, :header, :io

    def initialize(file)
      @file = file
      @variables = set_variables
    end

    def dataset
      @dataset ||= Dataset.new(
        io,
        @variables,
        buffer_length,
        buffer_offset
      )
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

    def buffer_offset
      header.var_buf[0].buf_offset
    end

    def buffer_length
      header.buf_len
    end
  end
end
