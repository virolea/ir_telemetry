# frozen_string_literal: true

module IRTelemetry
  class Headers::IRSDKVarHeader < BinData::Record
    endian :little

    int32 :var_type
    int32 :offset
    int32 :var_count

    bit8 :count_as_time
    string :pad, length: 3

    string :name, length: IBTFile::IRSDK_MAX_STRING, trim_padding: true
    string :desc, length: IBTFile::IRSDK_MAX_DESC, trim_padding: true
    string :unit, length: IBTFile::IRSDK_MAX_STRING, trim_padding: true
  end
end
