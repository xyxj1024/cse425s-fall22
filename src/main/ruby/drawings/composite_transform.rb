# __STUDENT_NAME__

require_relative 'transform'
class CompositeTransform < Transform
end



if __FILE__ == $0
  require_relative '../render/core/render_app'
  require_relative 'equilateral_triangle'
  require_relative 'rectangle'
  class House < CompositeTransform
    def initialize(x: 0, y: 0)
      super
      push_component(Rectangle.new(0.2, 0.2, y: -0.3, color:Color::ALIZARAN_CRIMSON))
      push_component(EquilateralTriangle.new(0.25, color: Color::JEEPERS_CREEPERS))
    end
  end
  app = RenderApp.new(House.new)
  app.main_loop
end

