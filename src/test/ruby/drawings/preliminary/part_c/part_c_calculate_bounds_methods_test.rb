require "test/unit"

require_relative '../../../drawings_util/require_all_but_composite'

class PartCCalculateBoundsMethodsTest < Test::Unit::TestCase
  @@object_direct_subclasses = [
    Transform,
    Scene
  ]
  @@transform_direct_subclasses = [
    ColorTransform,
    CompositeTransform,
    Image
  ]
  @@color_transform_direct_subclasses = [
    EquilateralTriangle,
    Rectangle,
    Ellipse,
    CircularSegment,
    Text,
    BezierCurve
  ]

  def test_public_calculate_bounds_defined
    (@@object_direct_subclasses + @@transform_direct_subclasses + @@color_transform_direct_subclasses).each do |cls|
      assert(cls.public_method_defined?(:bounds))
      # puts "#{cls} calculate_bounds"
    end
  end

  def test_private_calculate_untransformed_bounds_defined
    (@@transform_direct_subclasses + @@color_transform_direct_subclasses).each do |cls|
      unless cls == ColorTransform
        assert(cls.private_method_defined?(:untransformed_bounds), cls.to_s)
      end
    end
  end
end
