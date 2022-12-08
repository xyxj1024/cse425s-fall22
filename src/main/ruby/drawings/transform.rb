# Xingjian Xuanyuan

# Render Part B Assignment
# Useful links: https://rubystyle.guide
# Subclasses of Transform: Image, ColorTransform, CompositeTransform

class Transform
  # investigate cavalcade_of_graphics for example code
  def initialize(x, y)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end

  def render
    # preserve the current model view transform
    glPushMatrix

    # translate in the z = 0 plane
    glTranslated(@x, @y, 0.0)

    # invoke a method on itself
    # all subclasses must implement a private untransformed_render method
    self.untransformed_render

    # restore the model view transform
    glPopMatrix
  end
  
end
