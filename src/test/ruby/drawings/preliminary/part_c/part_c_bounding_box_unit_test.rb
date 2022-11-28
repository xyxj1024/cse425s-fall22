require "test/unit"

require_relative '../../../../../main/ruby/drawings/point2'
require_relative '../../../../../main/ruby/drawings/bounding_box'

class PartCBoundingBoxUnitTest < Test::Unit::TestCase
  def test_bounds
    min_x = 2
    min_y = 3
    max_x = 4
    max_y = 5
    bounds = BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
    assert_equal(bounds.min.x, min_x)
    assert_equal(bounds.min.y, min_y)
    assert_equal(bounds.max.x, max_x)
    assert_equal(bounds.max.y, max_y)
  end
end
