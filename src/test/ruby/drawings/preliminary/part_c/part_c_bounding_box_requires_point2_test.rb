require "test/unit"

class BoundingBoxRequiresPoint2Test < Test::Unit::TestCase
  def test_bounding_box_requires_point2
    # assert_false Object.const_defined?(:Point2)
    # assert_false Object.const_defined?(:BoundingBox)
    require_relative '../../../../../main/ruby/drawings/bounding_box'
    assert_true Object.const_defined?(:Point2)
    assert_true Object.const_defined?(:BoundingBox)
  end
end