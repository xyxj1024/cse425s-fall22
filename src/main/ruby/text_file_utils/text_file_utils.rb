# __STUDENT_NAME__
# Dennis Cosgrove

class TextFileUtils
  def self.write_text(path)
    
    raise "not_yet_implemented"
  end
end

if __FILE__ == $0
  require 'fileutils'
  directory_path = File.join(Dir.home, 'Downloads', 'CSE425s')
  FileUtils.mkdir_p directory_path
  path = File.join(directory_path, 'TextFileWriter.html')
  if File.exist?(path)
    File.delete(path)
  end
  TextFileUtils.write_text(path) do |file|
    file.write("<html><body><h1>#{Time.now}</h1></body></html>")
  end

  if Gem::Specification.all_names.include?('opener')
    require 'opener'
    Opener.spawn(path)
  else
    puts "=== note ===\n\nif you would like to automatically open the file in a browser, run: \n\ngem install opener\n\nat the command line (or if you require greater permission):\n\nsudo gem install opener\n\n============\n\n"
  end
  puts "contents of: #{path}\n#{File.read(path)}"
end
