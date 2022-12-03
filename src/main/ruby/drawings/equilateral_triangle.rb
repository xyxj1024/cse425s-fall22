# Xingjian Xuanyuan

class EquilateralTriangle
  # investigate cavalcade_of_graphics for example code
  def initialize(len)
    # attribute accessors for instance variable
    @half_side_length = len
    @height = Math.sqrt(3) * len
  end

  def half_side_length
    @half_side_length
  end

  def render
    # render a triangle
    glBegin(GL_TRIANGLES)
    glVertex2d(0, (2.0 * @height / 3.0))              # top
    glVertex2d(-@half_side_length, -(@height / 3.0))  # bottom left
    glVertex2d(@half_side_length, -(@height / 3.0))   # bottom right
    glEnd()
    # set the paint to red
    # glColor3f(1.0, 0.0, 0.0)
  end
end


if __FILE__ == $0
  require_relative '../render/core/render_app'
  half_side_length = 0.5
  app = RenderApp.new(EquilateralTriangle.new(half_side_length))
  app.main_loop
end
