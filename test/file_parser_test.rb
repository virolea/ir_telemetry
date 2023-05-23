# frozen_string_literal: true

require "test_helper"

class FileParserTest < ActiveSupport::TestCase
  setup do
    @ibt_file = "test/fixtures/files/clio.ibt"
  end

  test "parsing session info" do
    parser = IRTelemetry::FileParser.new(@ibt_file)
    parser.parse

    assert_equal "jerez gp", parser.session_info["WeekendInfo"]["TrackName"]
  end
end
