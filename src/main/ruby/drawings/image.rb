# __STUDENT_NAME__

require 'chunky_png'

class Image
  # investigate cavalcade_of_graphics for example code
end


if __FILE__ == $0
  require_relative '../render/core/render_app'
  require_relative '../../../core/ruby/download/download_utils'
  uri = 'https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/ruby/resources/dan128.png'
  path = DownloadUtils.download(uri)
  app = RenderApp.new(Image.new(path))
  app.main_loop
end
