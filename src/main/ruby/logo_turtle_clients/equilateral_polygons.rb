require_relative '../logo/turtle'

class EquilateralPolygons
  def initialize
    super
    @turtle = Turtle.new
  end

  def render
    @turtle.pen_color = Color::HONOLULU_BLUE
    triangle

    @turtle.right(90)

    @turtle.pen_width /= 2
    @turtle.pen_color = Color::PARIS_DAISY
    square

    @turtle.right(135)

    @turtle.pen_color = Color::FRENCH_VIOLET
    pentagon
  end

  private

  def triangle
    polygon(3)
  end

  def square
    polygon(4)
  end

  def pentagon
    polygon(5)
  end

  def polygon(n)
    @turtle.pen_width = 0.03
    n.times do
      @turtle.forward 0.5
      @turtle.right 360/n
      @turtle.pen_width /= 2
    end
  end
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(EquilateralPolygons.new)
  app.main_loop
end
