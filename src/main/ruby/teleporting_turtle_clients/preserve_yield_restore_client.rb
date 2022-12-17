require_relative '../branch/teleporting_turtle'

class PreserveYieldRestoreClient
  def initialize
    super
    @teleporting_turtle = TeleportingTurtle.new
  end

  def render
    @teleporting_turtle.pen_color = Color::DODGER_BLUE
    @teleporting_turtle.pen_width = 0.02
    @teleporting_turtle.forward(0.25)
    @teleporting_turtle.preserve_yield_restore do
      @teleporting_turtle.right(90)
      @teleporting_turtle.pen_color = Color::OUTRAGEOUS_ORANGE
      @teleporting_turtle.pen_width = 0.005
      45.times do
        @teleporting_turtle.right(5)
        @teleporting_turtle.forward(0.05)
      end
    end

    @teleporting_turtle.forward(0.25)
  end
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(PreserveYieldRestoreClient.new)
  app.main_loop
end