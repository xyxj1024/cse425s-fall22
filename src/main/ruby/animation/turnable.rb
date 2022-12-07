class Turnable
  attr_accessor :theta

  def initialize(transform)
    super()
    @transform = transform
    @theta = 0
  end

  def render
    glPushMatrix
    glRotatef(@theta, 0, 0, -1)
    @transform.render
    glPopMatrix
  end
end
