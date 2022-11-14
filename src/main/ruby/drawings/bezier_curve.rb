# __STUDENT_NAME__

require_relative 'point2'

# https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Quadratic_B%C3%A9zier_curves
class BezierCurve
  # investigate cavalcade_of_graphics for example code
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
