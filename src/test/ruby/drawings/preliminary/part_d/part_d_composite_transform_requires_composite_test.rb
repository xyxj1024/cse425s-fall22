require "test/unit"

require_relative '../../../drawings_util/requires_file_utils'

class CompositeTransformRequiresCompositeTest < Test::Unit::TestCase
  include RequiresFileUtils

  def test_composite_transform_requires_composite
    check_symbol(:Composite, :CompositeTransform, 'composite_transform')
  end
end