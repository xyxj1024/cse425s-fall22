require_relative '../../../core/ruby/snapshot/test_snapshots_web_page_generator'
require_relative '../../../test/ruby/drawings_util/part_a_info'

gen = TestSnapshotsWebPageGenerator.new(PartAInfo.new, "./part_a_test.html", "Render Part A", "part_a", is_complete: true)
gen.generate do |instance, eval_text|
  true
  # instance.instance_of?(EquilateralTriangle)
  # instance.instance_of?(Rectangle)
  # instance.instance_of?(Ellipse)
  # instance.instance_of?(CircularSegment)
  # instance.instance_of?(Image)
  # instance.instance_of?(Text)
  # instance.instance_of?(BezierCurve)
end
gen.teardown

