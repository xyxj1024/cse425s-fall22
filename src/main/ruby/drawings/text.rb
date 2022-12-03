# Xingjian Xuanyuan

require_relative '../render/core/font'

class Text
  # investigate cavalcade_of_graphics for example code
  def initialize(text, font)
    @text = text
    @font = font
  end

  def render
    bitmap_font = OpenGLUtils.to_bitmap_font(@font)
    glRasterPos2i(0, 0)
    @text.each_byte do |c|
      glutBitmapCharacter(bitmap_font, c)
    end
  end
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  text = "SML, Racket, and Ruby"
  app = RenderApp.new(Text.new(text, Font::TIMES_ROMAN_24))
  app.main_loop
end
