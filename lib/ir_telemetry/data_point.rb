# frozen_string_literal: true

module IRTelemetry
  class DataPoint
    VAR_TYPES_MAPPING = {
      1 => {
        size: 1,
        type: :irsdk_bool,
        handler: BinData::Bit8
      },
      2 => {
        size: 4,
        type: :irsdk_int,
        handler: BinData::Int32le
      },
      3 => {
        size: 4,
        type: :irsdk_bit_field,
        handler: BinData::Int32le
      },
      4 => {
        size: 4,
        type: :irsdk_float,
        handler: BinData::FloatLe
      },
      5 => {
        size: 8,
        type: :irsdk_double,
        handler: BinData::DoubleLe
      }
    }.freeze

    def initialize(buffer, dataset)
      @buffer = buffer
      @dataset = dataset
    end

    def [](variable_name)
      variable = @dataset.variables[variable_name]
      type = VAR_TYPES_MAPPING[variable.var_type]

      type[:handler].read(
        @buffer.byteslice(variable.offset, type[:size])
      )
    end
  end
end
