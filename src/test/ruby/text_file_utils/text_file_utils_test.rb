require "test/unit"

require_relative '../../../main/ruby/text_file_utils/text_file_utils'

class ContrivedError < StandardError
end

class TextFilesTest < Test::Unit::TestCase
  def test_closed_after_success_with_block
    expected_text = self.class.name
    file_passed_to_block = nil
    file_path = file_path_delete_if_necessary
    result = TextFileUtils.write_text(file_path) do |file|
      file_passed_to_block = file
      assert_false(file.closed?)
      file.write(expected_text)
    end

    assert_not_nil(file_passed_to_block)
    assert_same(result, file_passed_to_block)
    assert_true(result.closed?)

    actual_text = File.read(file_path)
    assert_equal(expected_text, actual_text)
    File.delete(file_path) if File.exist?(file_path)
  end

  def test_closed_after_error_with_block
    file_passed_to_block = nil
    file_path = file_path_delete_if_necessary
    begin
      TextFileUtils.write_text(file_path) do |file|
        file_passed_to_block = file
        assert_false(file.closed?)
        raise ContrivedError.new
      end
    rescue ContrivedError => e
      assert_true(file_passed_to_block.closed?)
    end
    File.delete(file_path) if File.exist?(file_path)
  end

  def test_open_without_block
    file_path = file_path_delete_if_necessary
    result = TextFileUtils.write_text(file_path)
    assert_not_nil(result)
    assert_false(result.closed?)
    result.close
    File.delete(file_path) if File.exist?(file_path)
  end

  private

  def file_path_delete_if_necessary
    directory_path = File.join(Dir.home, 'Downloads', "CSE425s")
    FileUtils.mkdir_p(directory_path)
    file_path = File.join(directory_path, "test_file.txt")
    File.delete(file_path) if File.exist?(file_path)
    file_path
  end
end

