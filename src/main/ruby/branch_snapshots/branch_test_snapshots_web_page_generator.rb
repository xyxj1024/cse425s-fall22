require_relative '../render/core/color'
require_relative '../../../core/ruby/snapshot/test_snapshots_web_page_generator.rb'
require_relative '../../../test/ruby/branch_util/branch_info.rb'

gen = TestSnapshotsWebPageGenerator.new(BranchInfo.new, "./branch_test.html", "Render Branch", "branch", is_diff_desired: false, snapshot_generator: SnapshotGenerator.new(width: 400, height: 400, clear_color: Color::WHITE))
gen.generate
gen.teardown