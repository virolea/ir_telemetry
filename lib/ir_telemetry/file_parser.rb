# frozen_string_literal: true

require "yaml"

module IRTelemetry
  class FileParser
    IRSDK_HEADER_SIZE = 112
    IRSDK_VAR_HEADER_SIZE = 144

    IRSDK_MAX_STRING = 32
    IRSDK_MAX_DESC = 64

    IBT_FILE_ENCONDING = "Windows-1252"

    attr_reader :session_info

    def initialize(filepath)
      @filepath = filepath
    end

    def parse
      File.open(@filepath, "rb") do |io|
        header = Headers::IRSDKHeader.read(io)

        parse_session_info(header.session_info_len, header.session_info_offset, io)
      end
    end

    private

    def parse_session_info(session_info_len, session_info_offset, io)
      io.seek(session_info_offset)
      session_string = io.read(session_info_len)
      session_string.force_encoding(IBT_FILE_ENCONDING)
      session_string.encode("UTF-8")

      @session_info = YAML.safe_load(session_string, permitted_classes: [Date])
    end
  end
end
