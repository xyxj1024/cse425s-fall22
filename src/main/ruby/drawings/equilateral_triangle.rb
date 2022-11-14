# __STUDENT_NAME__

class EquilateralTriangle
  # investigate cavalcade_of_graphics for example code
end


if __FILE__ == $0
  require_relative '../render/core/render_app'
  half_side_length = 0.5
  app = RenderApp.new(EquilateralTriangle.new(half_side_length))
  app.main_loop
end
