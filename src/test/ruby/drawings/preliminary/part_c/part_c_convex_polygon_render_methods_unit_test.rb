require "test/unit"
require_relative '../../../../../main/ruby/drawings/convex_polygon'

class PartCConvexPolygonRenderMethodsUnitTest < Test::Unit::TestCase
  def test_public_render_defined
    assert(ConvexPolygon.public_method_defined?(:render))
  end

  def test_private_untransformed_render_defined
    assert(ConvexPolygon.private_method_defined?(:untransformed_render))
  end
end