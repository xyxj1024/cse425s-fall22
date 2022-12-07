class Animation
  def initialize(transform, t0, duration)
    super()
    @transform = transform
    @t0 = t0
    @duration = duration
  end

  def update(t, dt)
    if(t>=@t0 and t<=@t0+@duration)
      filtered_update(t,dt)
    end
  end

  private

  def filtered_update(t,dt)
    raise "override method: #{__method__} on class: #{self.class}"
  end
end
