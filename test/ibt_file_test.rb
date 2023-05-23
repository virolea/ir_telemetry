# frozen_string_literal: true

require "test_helper"

class FileParserTest < ActiveSupport::TestCase
  setup do
    @ibt_filepath = "test/fixtures/files/clio.ibt"
  end

  test "parsing session info" do
    IRTelemetry::IBTFile.open(@ibt_filepath) do |io|
      assert_equal io.session_info["WeekendInfo"]["TrackName"], "jerez gp"
    end
  end
end
