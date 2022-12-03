# Xingjian Xuanyuan

class Ellipse
  # investigate cavalcade_of_graphics for example code
  def initialize(x_radius, y_radius)
    @x_radius = x_radius
    @y_radius = y_radius
  end

  def x_radius
    @x_radius
  end

  def y_radius
    @y_radius
  end

  def render
    # render an ellipse
    slice_count = 32
    delta_theta = (2 * Math::PI) / slice_count
    theta = 0
    glBegin(GL_POLYGON)
    slice_count.times do
      glVertex2f(@x_radius * Math.cos(theta), @y_radius * Math.sin(theta))
      theta += delta_theta
    end
    glEnd()
  end
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  x_radius = 0.3
  y_radius = 0.4
  app = RenderApp.new(Ellipse.new(x_radius, y_radius))
  app.main_loop
end
