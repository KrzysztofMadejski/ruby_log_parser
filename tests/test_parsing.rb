require "./lib/parser.rb"
require "test/unit"

class TestParsing < Test::Unit::TestCase
  def setup
    @l = LogParser.new("tests/cases/simple.log")
    @l.call
  end

  def test_all_logs
    assert_equal(6, @l.size)
    assert_instance_of(Log, @l[0])
  end

  def test_unique
    assert_equal(3, @l.unique.size)
    assert_equal({
                     "/help_page/1" => 1,
                     '/contact/2' => 2,
                     '/about/1' => 1
                 }, @l.unique)
  end

  def test_unique_each
    assert_respond_to(@l.unique, :each)
  end

  def test_unique_order
    assert_respond_to(@l.unique, :order)
    unique = @l.unique.order(views: :desc)
    assert_equal(['/contact/2', 2], unique[0])

    unique = @l.unique.order(views: :asc)
    assert_equal(['/contact/2', 2], unique[2])
  end
end