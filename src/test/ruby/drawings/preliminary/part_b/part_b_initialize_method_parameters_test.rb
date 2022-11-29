require "test/unit"

require_relative '../../../drawings_util/parameter_test_utils'

require_relative '../../../../../main/ruby/drawings/equilateral_triangle'
require_relative '../../../../../main/ruby/drawings/rectangle'
require_relative '../../../../../main/ruby/drawings/ellipse'
require_relative '../../../../../main/ruby/drawings/image'
require_relative '../../../../../main/ruby/drawings/text'
require_relative '../../../../../main/ruby/drawings/circular_segment'
require_relative '../../../../../main/ruby/drawings/bezier_curve'


class PartBInitializeMethodParametersTest < Test::Unit::TestCase
  def test_equilateral_triangle_constructor_parameters
    assert_x_y_color(EquilateralTriangle, 1)
  end

  def test_rectangle_constructor_parameters
    assert_x_y_color(Rectangle, 2)
  end

  def test_ellipse_constructor_parameters
    assert_x_y_color(Ellipse, 2)
  end

  def test_circular_segment_constructor_parameters
    assert_x_y_color(CircularSegment, 4)
  end

  def test_text_constructor_parameters
    assert_x_y_color(Text, 2)
  end

  def test_bezier_curve_constructor_parameters
    assert_x_y_color(BezierCurve, 1)
  end

  def test_image_constructor_parameters
    assert_x_y(Image, 1)
  end

  private


  def assert_x_y(cls, required_parameter_count)
    ParameterTestUtils.new.assert_key_parameters_over_optional_parameters(cls.instance_method(:initialize), required_parameter_count, [:x, :y])
  end

  def assert_x_y_color(cls, required_parameter_count)
    ParameterTestUtils.new.assert_key_parameters_over_optional_parameters(cls.instance_method(:initialize), required_parameter_count, [:x, :y, :color])
  end
end
