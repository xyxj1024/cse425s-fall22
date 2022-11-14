# __STUDENT_NAME__

class CircularSegment
  # investigate cavalcade_of_graphics for example code
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  x_radius = 0.6
  y_radius = 0.8
  theta_a = Math::PI/4
  theta_z = (3*Math::PI)/4
  app = RenderApp.new(CircularSegment.new(x_radius, y_radius, theta_a, theta_z))
  app.main_loop
end
