require_relative '../drawings/composite_transform'
require_relative '../drawings/rectangle'
require_relative '../drawings/equilateral_triangle'
require_relative '../drawings/convex_polygon'
require_relative '../drawings/point2'
class Tower < CompositeTransform
  def initialize(base_color, x: 0, y: 0)
    super(x:x, y:y)
    half_height = 0.25
    base_color = Color.new(0.7, 0.7, 0.7)
    base = Rectangle.new(0.05, half_height, y: -0.15, color: base_color)

    roof = EquilateralTriangle.new(0.1, y: 0.1, color: Color::JEEPERS_CREEPERS)

    pts = [Point2.new(0, 0.02), Point2.new(0, -0.02), Point2.new(0.1, 0.0) ]
    flag = ConvexPolygon.new(pts, y: 0.22, color: Color::CARMINE)


    push_component(base)
    push_component(roof)
    push_component(flag)
  end
end

class BigTop < CompositeTransform
  def initialize(x: 0, y: 0)
    super
    base_color = Color.new(0.8, 0.8, 0.8)
    base_half_height = 0.2
    base = Rectangle.new(0.5, base_half_height, y: -base_half_height, color: base_color)

    door_color = Color::BAMBOO
    door_half_width = 0.1
    door_top = Ellipse.new(door_half_width, door_half_width, y: -0.25, color: door_color)
    door_bottom = Rectangle.new(door_half_width, 0.08, y: -0.32, color: door_color)
    tower_left = Tower.new(base_color, x: -0.5)
    tower_center = Tower.new(base_color, y: 0.1)
    tower_right = Tower.new(base_color, x: 0.5)

    push_component(tower_center)
    push_component(base)
    push_component(door_bottom)
    push_component(door_top)
    push_component(tower_left)
    push_component(tower_right)
  end
end
