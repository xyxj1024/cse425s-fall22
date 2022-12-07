require_relative 'animation'

class MoveAnimation < Animation
  def initialize(transform, t0, duration, x_velocity, y_velocity)
    super(transform, t0, duration)
    @x_velocity = x_velocity
    @y_velocity = y_velocity
  end

  private

  def filtered_update(t,dt)
    @transform.x += @x_velocity*dt
    @transform.y += @y_velocity*dt
  end
end
