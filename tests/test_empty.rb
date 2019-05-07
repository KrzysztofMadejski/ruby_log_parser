require "./lib/parser"
require "test/unit"

class TestEmpty < Test::Unit::TestCase
  def test_nonexistent_file
    assert_raise Errno::ENOENT do
      l = LogParser.new("nonexistent.log")
      l.call()
    end
  end

  def test_empty
    l = LogParser.new("tests/cases/empty.log")
    l.call
    assert(l.empty?)
    assert(l.unique.empty?)
  end
end