# Xingjian Xuanyuan

class Ellipse
  # investigate cavalcade_of_graphics for example code
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  x_radius = 0.3
  y_radius = 0.4
  app = RenderApp.new(Ellipse.new(x_radius, y_radius))
  app.main_loop
end
