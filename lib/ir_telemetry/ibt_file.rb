# frozen_string_literal: true

require "yaml"
require "date"

module IRTelemetry
  class IBTFile
    IRSDK_HEADER_SIZE = 112
    IRSDK_VAR_HEADER_SIZE = 144

    IRSDK_MAX_STRING = 32
    IRSDK_MAX_DESC = 64

    IBT_FILE_ENCODING = "Windows-1252"

    class << self
      def open(filepath, &block)
        io = new(filepath)
        block.call(io)
      ensure
        io&.close
      end
    end

    def initialize(filepath)
      @io = File.open(filepath, "rb")
      @header = Headers::IRSDKHeader.read(@io)
    end

    def close
      @io.close
    end

    def session_info
      @io.seek(@header.session_info_offset)
      session_string = @io.read(@header.session_info_len)
      session_string.force_encoding(IBT_FILE_ENCODING)
      session_string.encode("UTF-8")

      YAML.safe_load(session_string, permitted_classes: [Date])
    end
  end
end
