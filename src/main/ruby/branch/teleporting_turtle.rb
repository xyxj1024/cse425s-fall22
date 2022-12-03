require_relative '../logo/turtle'

# Xingjian Xuanyuan
# Dennis Cosgrove

class TeleportingTurtle < Turtle
  def initialize
    super
    @pen_width_stack = []
    @pen_color_stack = []
  end

  def preserve_yield_restore
    
    raise "not_yet_implemented"
  end

  private

  def preserve_state
    @pen_width_stack.push(pen_width)
    @pen_color_stack.push(pen_color)
    glPushMatrix
  end

  def restore_state
    glPopMatrix
    # note self. required to invoke pen_color and pen_width methods as opposed to adding local variables
    self.pen_color = @pen_color_stack.pop
    self.pen_width = @pen_width_stack.pop
  end
end
