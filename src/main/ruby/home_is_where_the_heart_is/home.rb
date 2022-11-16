# __STUDENT_NAME__
# Dennis Cosgrove

require_relative '../drawings/rectangle'
require_relative '../drawings/equilateral_triangle'
require_relative '../render/core/color'

class Home

end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(Home.new)
  app.main_loop
end