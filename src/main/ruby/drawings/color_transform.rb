# Xingjian Xuanyuan

# Render Part B Assignment
require_relative 'transform'
require_relative '../render/core/color'

class ColorTransform < Transform
  # investigate cavalcade_of_graphics for example code
  def initialize(x, y, color)
    # x and y should be passed to the superclass
    @color_transform = Transform.new(x, y)
    # color should be stored in an instance variable
    @color = color
  end

  private
  def untransformed_render
    if !@color_transform.nil?
      # set the color to magenta
      glColor3f(1.0, 0.0, 1.0)
    end
  end
  
end
