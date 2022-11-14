# __STUDENT_NAME__

require_relative '../render/core/font'

class Text
  # investigate cavalcade_of_graphics for example code
end



if __FILE__==$0
  require_relative '../render/core/render_app'
  text = "SML, Racket, and Ruby"
  app = RenderApp.new(Text.new(text, Font::TIMES_ROMAN_24))
  app.main_loop
end
