# __STUDENT_NAME__
# Dennis Cosgrove

require_relative '../drawings/rectangle'
require_relative '../drawings/ellipse'
require_relative '../render/core/color'

class Heart
  
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(Heart.new)
  app.main_loop
end