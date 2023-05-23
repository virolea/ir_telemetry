# frozen_string_literal: true

module IRTelemetry
  class Headers::IRSDKHeader < BinData::Record
    IRSDK_MAX_BUFS = 4

    endian :little

    int32 :version
    int32 :status
    int32 :tick_rate

    int32 :session_info_update
    int32 :session_info_len
    int32 :session_info_offset

    int32 :num_vars
    int32 :var_header_offset

    int32 :num_buf
    int32 :buf_len
    array :pad, type: :int32, initial_length: 2

    array :var_buf, initial_length: IRSDK_MAX_BUFS do
      endian :little

      int32 :tick_count
      int32 :buf_offset
      array :pad, type: :int32, initial_length: 2
    end
  end
end
