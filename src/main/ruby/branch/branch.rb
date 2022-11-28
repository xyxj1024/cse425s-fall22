require_relative 'teleporting_turtle'

# __STUDENT_NAME__
# Dennis Cosgrove

class Branch
  def initialize(length: 1.4, line_width: 0.01, max_depth: 3, wood_color: Color::CARMINE, leaf_color: Color::JEEPERS_CREEPERS, clear_color: Color::WHITE)
    super()
    @length = length
    @line_width = line_width
    @max_depth = max_depth

    @wood_color = wood_color
    @leaf_color = leaf_color
    @clear_color = clear_color

    @teleporting_turtle = TeleportingTurtle.new
  end

  def render
    glTranslatef(-0.9, 0.0, 0.0)
    glRotatef(-90, 0.0, 0.0, 1.0)
    glClearColor(@clear_color.red, @clear_color.green, @clear_color.blue, 1.0)
    branch(@length, @line_width, @max_depth)
  end

  private

  def branch(length, line_width, depth_remaining)
    
    raise "not_yet_implemented"
  end
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(Branch.new)
  app.main_loop
end
