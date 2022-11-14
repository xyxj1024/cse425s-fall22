# Xingjian Xuanyuan

class EquilateralTriangle
  # investigate cavalcade_of_graphics for example code
  def initialize(len)
    # attribute accessors for instance variable
    @half_side_length = len
    @height = sqrt(3) * len
    # render a triangle
    glBegin(GL_TRIANGLES)
    glVertex2d(0, (2.0f * @height / 3.0f))  # top
    glVertex2d(-len, -(@height / 3.0f))     # bottom left
    glVertex2d(len, -(@height / 3.0f))      # bottom right
    glEnd()
    # set the paint to red
    # glColor3f(1.0, 0.0, 0.0)
  end

  def half_side_length
    self.half_side_length
  end

  def render
    equilateral_triangle = EquilateralTriangle.new(0.5)
  end
end


if __FILE__ == $0
  require_relative '../render/core/render_app'
  half_side_length = 0.5
  app = RenderApp.new(EquilateralTriangle.new(half_side_length))
  app.main_loop
end
