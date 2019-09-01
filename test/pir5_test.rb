require 'test_helper'

class Pir5Test < Minitest::Test
  def test_version
    refute_nil Pir5::VERSION
  end
end
