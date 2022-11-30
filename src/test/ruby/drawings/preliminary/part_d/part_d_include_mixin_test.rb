require "test/unit"

require_relative '../../../../../main/ruby/drawings/composite'
require_relative '../../../../../main/ruby/drawings/scene'
require_relative '../../../../../main/ruby/drawings/composite_transform'

class PartDIncludeMixinTest < Test::Unit::TestCase
  def test_mixes_in_composite
    [Scene, CompositeTransform].each do |cls|
      assert_include(cls.included_modules, Composite)
    end
  end

  def test_mixes_in_enumerable
    [Composite, Scene, CompositeTransform].each do |cls|
      assert_include(cls.included_modules, Enumerable)
    end
  end
end



