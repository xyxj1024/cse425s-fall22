class TurnAnimation < Animation
  def initialize(transform, t0, duration, theta_velocity)
    super(transform, t0, duration)
    @theta_velocity = theta_velocity
  end

  private

  def filtered_update(t,dt)
    @transform.theta += @theta_velocity*dt
  end
end