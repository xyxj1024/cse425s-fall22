# __STUDENT_NAME__

class Rectangle
  # investigate cavalcade_of_graphics for example code
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  phi = 1.618
  half_height = 0.5
  half_width = phi*half_height
  app = RenderApp.new(Rectangle.new(half_width, half_height))
  app.main_loop
end
