# Xingjian Xuanyuan

require_relative 'point2'

# https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Quadratic_B%C3%A9zier_curves
class BezierCurve
  # investigate cavalcade_of_graphics for example code
  def initialize(control_points)
    @control_points = control_points
  end

  def render
    flat_xyzs = []
    @control_points.each do |p|
      flat_xyzs.push(p.x_coord)
      flat_xyzs.push(p.y_coord)
      flat_xyzs.push(0.0)
    end

    control_data = flat_xyzs.pack("f*")

    # set the color to white
    glColor3f(1.0, 1.0, 1.0)
    glMap1f(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, @control_points.length, control_data)
    glEnable(GL_MAP1_VERTEX_3)
    glBegin(GL_LINE_STRIP)
    resolution_of_curve = 48
    resolution_of_curve.times do |i|
      glEvalCoord1f(i.to_f / resolution_of_curve)
    end
    glEvalCoord1d(1.0)
    glEnd()
  end
end

if __FILE__==$0
  require_relative '../render/core/render_app'
  control_points = [
      Point2.new(-0.5, -0.5),
      Point2.new(0.0, +0.5),
      Point2.new(0.5, -0.5)
  ]
  app = RenderApp.new(BezierCurve.new(control_points))
  app.main_loop
end
