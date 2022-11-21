require_relative '../../../core/ruby/snapshot/test_snapshots_web_page_generator'
require_relative '../../../test/ruby/drawings_util/part_b_components_info'


gen = TestSnapshotsWebPageGenerator.new(PartBComponentsInfo.new, "./part_b_test.html", "Render Part B", "part_b", is_complete: true)
gen.generate do |instance, eval_text|
  true
  # eval_text.include?('color: ')
  # instance.instance_of?(EquilateralTriangle)
  # instance.instance_of?(Rectangle)
  # instance.instance_of?(Ellipse)
  # instance.instance_of?(CircularSegment)
  # instance.instance_of?(Image)
  # instance.instance_of?(Text)
  # instance.instance_of?(BezierCurve)
end
gen.teardown

