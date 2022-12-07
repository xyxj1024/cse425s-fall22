require_relative '../render/core/color'
require_relative '../drawings/composite_transform'
require_relative '../drawings/circular_segment'
require_relative '../drawings/ellipse'
require_relative '../drawings/rectangle'
require_relative '../drawings/text'

require_relative '../animation/turnable'

class WheelHousing < CompositeTransform
  attr_reader :tire_turnable
  attr_reader :tire_radius

  def initialize(x: 0, y: 0)
    super

    accent_color = Color::ALIZARAN_CRIMSON
    well_color = Color.new(0.3, 0.3, 0.3)
    tire_color = Color.new(0, 0, 0)
    hub_cap_color = Color.new( 0.8, 0.8, 0.8)

    accent_radius = 0.21
    sep_radius = 0.15

    @tire_radius = 0.12
    accent = CircularSegment.new(accent_radius, accent_radius, 0, Math::PI, color: accent_color)
    tire_sep = CircularSegment.new(sep_radius, sep_radius, 0, Math::PI, color: well_color)
    tire = Ellipse.new(@tire_radius, @tire_radius, color: tire_color)
    hub_cap = Ellipse.new(0.07, 0.07, color: hub_cap_color)

    detail_a = Rectangle.new(0.01, 0.05, color: Color::JAZZBERRY_JAM)
    detail_b = Rectangle.new(0.05, 0.01, color: Color::JAZZBERRY_JAM)
    # detail = Text.new("WU", Font::TIMES_ROMAN_10, x: -0.03, y: -0.015, color: Color::OCEAN_GREEN)

    tire_transform = CompositeTransform.new
    tire_transform.push_component(tire)
    tire_transform.push_component(hub_cap)
    tire_transform.push_component(detail_a)
    tire_transform.push_component(detail_b)
    @tire_turnable = Turnable.new(tire_transform)

    @components.push(accent)
    @components.push(tire_sep)
    @components.push(@tire_turnable)
  end
end

class Car < CompositeTransform
  def initialize(x: 0, y: 0)
    super

    base_color = Color::BRIGHT_SPARK
    window_color = Color::AQUAMARINE
    nose_color = Color::ALIZARAN_CRIMSON

    nose_radius = 0.07
    nose = Ellipse.new(nose_radius, nose_radius, x: 0.7, y: 0.5, color: nose_color)
    base_a = CircularSegment.new(0.7, 0.8, Math::PI/9, 8*Math::PI/9, color: base_color)

    y = 0.275
    base_b = CircularSegment.new(0.4, 0.3, 0, Math::PI, x: 0.4, y: y, color: base_color)

    @front_wheel_housing = WheelHousing.new(x: 0.55, y: y)
    @back_wheel_housing = WheelHousing.new(x: -0.4, y: y)

    windows = CircularSegment.new(base_a.x_radius*0.9, base_a.y_radius*0.9, Math::PI/4, 3*Math::PI/4, y: 0.05, color: window_color)

    separator = Rectangle.new(0.025, 0.26, x: 0, y: 0.54, color: base_color)
    separator_thin = Rectangle.new(0.0025, 0.24, x: 0, y: 0.54, color: Color.new(0.4,0.4,0.4))
    line = Rectangle.new(0.35, 0.01, x: 0.1, y: 0.29, color: Color.new(0.4,0.4,0.4))

    @components.push(nose)
    @components.push(base_a)
    @components.push(base_b)
    @components.push(windows)
    @components.push(separator)
    @components.push(separator_thin)
    @components.push(line)
    @components.push(@front_wheel_housing)
    @components.push(@back_wheel_housing)
  end

  def tire_radius
    @front_wheel_housing.tire_radius
  end

  def tires
    [@front_wheel_housing.tire_turnable, @back_wheel_housing.tire_turnable]
  end

  # def render
  #   # color = Color::DODGER_BLUE
  #   # glClearColor(color.red, color.green, color.blue, 1.0)
  #   Rectangle.new(2.0, 0.7, y: -0.35, color: Color::JEEPERS_CREEPERS).render
  #   super
  # end
end
