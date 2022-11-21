# __STUDENT_NAME__

class Scene
  # investigate cavalcade_of_graphics for example code
end



if __FILE__ == $0
  require_relative '../render/core/render_app'
  require_relative 'equilateral_triangle'
  require_relative 'rectangle'
  require_relative 'composite_transform'
  class House < CompositeTransform
    def initialize(x: 0, y: 0)
      super
      push_component(Rectangle.new(0.2, 0.2, y: -0.3, color:Color::ALIZARAN_CRIMSON))
      push_component(EquilateralTriangle.new(0.25, color: Color::JEEPERS_CREEPERS))
    end
  end

  scene = Scene.new
  scene.push_component(House.new(x: -0.4, y: 0.5))
  scene.push_component(House.new(x: +0.2, y: -0.2))
  app = RenderApp.new(scene)
  app.main_loop
end
