require_relative 'car'
require_relative 'big_top'
require_relative '../drawings/scene'
require_relative '../animation/time_line'
require_relative '../animation/move_animation'
require_relative '../animation/turn_animation'

class ClownShow
  def initialize
    super
    ground = Rectangle.new(2.0, 0.7, y: -0.35, color: Color::JEEPERS_CREEPERS)
    car = Car.new(x: -1.5, y: -0.75)

    big_top = BigTop.new(x: 0.2, y: 0.5)

    @scene = Scene.new(background_color: Color::SUMMER_SKY)
    @scene.push_component(ground)
    @scene.push_component(big_top)
    @scene.push_component(car)

    car_drive_duration = 3
    x_velocity = 0.4
    @time_line = TimeLine.new
    @time_line.add_animation(MoveAnimation.new(car, 0, car_drive_duration, x_velocity, 0))
    car.tires.each do |tire|
      circ = car.tire_radius * 2 * Math::PI
      theta = x_velocity / circ
      theta_velocity = 360 * theta
      @time_line.add_animation(TurnAnimation.new(tire, 0, car_drive_duration, theta_velocity))
    end
  end

  def render
    @time_line.update
    @scene.render
  end
end

if __FILE__ == $0
  require_relative '../render/core/render_app'
  app = RenderApp.new(ClownShow.new)
  app.main_loop
end