# Xingjian Xuanyuan

class Rectangle
  # investigate cavalcade_of_graphics for example code
  def initialize(hw, hh)
    @half_width = hw
    @half_height = hh
  end

  def half_width
    @half_width
  end

  def half_height
    @half_height
  end

  def render
    # render a rectangle
    glBegin(GL_QUADS)
    glVertex2d(@half_width, -@half_height)   # bottom right
    glVertex2d(@half_width, @half_height)    # top right
    glVertex2d(-@half_width, @half_height)   # top left
    glVertex2d(-@half_width, -@half_height)  # bottom left
    glEnd()
  end
end


if __FILE__==$0
  require_relative '../render/core/render_app'
  phi = 1.618
  half_height = 0.5
  half_width = phi * half_height
  app = RenderApp.new(Rectangle.new(half_width, half_height))
  app.main_loop
end
