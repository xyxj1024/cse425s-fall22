require_relative '../logo/turtle'

class Flower
  def initialize
    super
    @turtle = Turtle.new
  end

  def render
    flower
  end

  private

  def square
    4.times do
      @turtle.forward 0.5
      @turtle.right 90
    end
  end

  def flower
    36.times do
      @turtle.right 10
      square
    end
  end
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(Flower.new)
  app.main_loop
end
