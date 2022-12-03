# Xingjian Xuanyuan

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
    glPushMatrix()
    # translate
    glTranslated(0.5, 0.0, 0)
    # restore the model view transform
    glPopMatrix()
  end
  
end
