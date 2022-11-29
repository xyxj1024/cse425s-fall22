require "test/unit"

require_relative '../../../drawings_util/parameter_test_utils'

require_relative '../../../../../main/ruby/drawings/convex_polygon'


class PartCInitializeMethodParametersTest < Test::Unit::TestCase
  def test_convex_polygon_constructor_parameters
    assert_x_y_color(ConvexPolygon, 1)
  end

  private

  def assert_x_y_color(cls, required_parameter_count)
    ParameterTestUtils.new.assert_key_parameters_over_optional_parameters(cls.instance_method(:initialize), required_parameter_count, [:x, :y, :color])
  end
end
