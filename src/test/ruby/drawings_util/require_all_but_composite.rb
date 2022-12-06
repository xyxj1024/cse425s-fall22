path = File.join(File.dirname(__FILE__), '../../../main/ruby/drawings/')
raise StandardError unless File.directory?(path)
full_path = File.join(path, File.basename('transform.rb'))
require_relative full_path
full_path = File.join(path, File.basename('color_transform.rb'))
require_relative full_path
Dir.entries(path).each do |file|
  if File.extname(file) == '.rb'
    unless File.basename(file) == 'composite.rb'
      full_path = File.join(path, File.basename(file))
      require_relative full_path
    end
  end
end
