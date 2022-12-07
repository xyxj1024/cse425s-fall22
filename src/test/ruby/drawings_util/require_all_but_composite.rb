path = File.join(File.dirname(__FILE__), '../../../main/ruby/drawings/')
raise StandardError unless File.directory?(path)

files_to_require_in_specific_order = ['point2.rb', 'bounding_box.rb', 'transform.rb', 'color_transform.rb']

files_to_require_in_specific_order.each do |file|
  full_path = File.join(path, File.basename(file))
  if File.exist?(full_path)
    require_relative full_path
  end
end

Dir.entries(path).each do |file|
  if File.extname(file) == '.rb'
    unless files_to_require_in_specific_order.include?(File.basename(file))
      full_path = File.join(path, File.basename(file))
      require_relative full_path
    end
  end
end
