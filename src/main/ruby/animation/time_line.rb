class TimeLine
  def initialize
    super
    @animations = []
    @start_time = nil
    @prev_time = nil
  end

  def add_animation(animation) #, t0, duration)
    @animations.push(animation)
  end

  def update
    now = Time.now.to_f
    if @start_time.nil?
      @start_time = now
      @prev_time = 0
    end

    t = now-@start_time
    dt = t-@prev_time
    @animations.each do |animation|
      animation.update(t, dt)
    end
    @prev_time = t
  end
end
