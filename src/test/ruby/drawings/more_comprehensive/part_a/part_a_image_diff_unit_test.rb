require "test/unit"

require_relative '../../../../../core/ruby/snapshot/image_diff_unit_test_mixin'
require_relative '../../../drawings_util/part_a_info'

class PartAImageDiffUnitTest < Test::Unit::TestCase
  # generated begin

  def test_picture_diff_EquilateralTriangle_A
    pictures_close_enough("EquilateralTriangle.new(0.5)",
                          "EquilateralTriangle_A")
  end

  def test_picture_diff_EquilateralTriangle_B
    pictures_close_enough("EquilateralTriangle.new(0.1)",
                          "EquilateralTriangle_B")
  end

  def test_picture_diff_Rectangle_A
    pictures_close_enough("Rectangle.new(0.4, 0.6)",
                          "Rectangle_A")
  end

  def test_picture_diff_Rectangle_B
    pictures_close_enough("Rectangle.new(0.7, 0.1)",
                          "Rectangle_B")
  end

  def test_picture_diff_Ellipse_A
    pictures_close_enough("Ellipse.new(0.1, 0.2)",
                          "Ellipse_A")
  end

  def test_picture_diff_Ellipse_B
    pictures_close_enough("Ellipse.new(0.3, 0.4)",
                          "Ellipse_B")
  end

  def test_picture_diff_CircularSegment_A
    pictures_close_enough("CircularSegment.new(0.3, 0.4, -Math::PI/3, Math::PI/2)",
                          "CircularSegment_A")
  end

  def test_picture_diff_CircularSegment_B
    pictures_close_enough("CircularSegment.new(0.7, 0.5, Math::PI, 3*Math::PI/2)",
                          "CircularSegment_B")
  end

  def test_picture_diff_Image_A
    pictures_close_enough("path = DownloadUtils.download_if_necessary('https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/resources/dan128.png');Image.new(path)",
                          "Image_A")
  end

  def test_picture_diff_Text_A
    pictures_close_enough("Text.new(\"SML\", Font::TIMES_ROMAN_24)",
                          "Text_A")
  end

  def test_picture_diff_Text_B
    pictures_close_enough("Text.new(\"Racket\", Font::TIMES_ROMAN_24)",
                          "Text_B")
  end

  def test_picture_diff_Text_C
    pictures_close_enough("Text.new(\"Ruby\",Font::TIMES_ROMAN_24)",
                          "Text_C")
  end

  def test_picture_diff_Text_D
    pictures_close_enough("Text.new(\"Java\", Font::TIMES_ROMAN_24)",
                          "Text_D")
  end

  def test_picture_diff_BezierCurve_A
    pictures_close_enough("p0 = Point2.new(-0.5, -0.5);p1 = Point2.new(-0.25, 0.25);p2 = Point2.new(0.25, -0.5);p3 = Point2.new(0.5, 0.5);BezierCurve.new([p0, p1, p2, p3])",
                          "BezierCurve_A")
  end

  def test_picture_diff_BezierCurve_B
    pictures_close_enough("p0 = Point2.new(0.3, 0.5);p1 = Point2.new(0.25, -0.25);p2 = Point2.new(-0.25, 0.75);p3 = Point2.new(-0.25, -0.25);BezierCurve.new([p0, p1, p2, p3])",
                          "BezierCurve_B")
  end

  # generated end

  def self.startup
    @@pictures, @@exceptions = ImageDiffUnitTestSetup.setup_pictures_and_exceptions(PartAInfo.new)
  end

  private

  include ImageDiffUnitTestMixin

  def expected_sub_path
    'part_a'
  end

  def setup_exception_hash
    @@exceptions
  end

  def setup_picture_hash
    @@pictures
  end
end