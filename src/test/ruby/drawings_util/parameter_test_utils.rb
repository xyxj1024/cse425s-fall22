require "test/unit"

class ParameterTestUtils

  include Test::Unit::Assertions

  def assert_key_parameters_over_optional_parameters(method, target_required_parameter_count, target_keyword_parameters)
    actual_optional_parameters = []
    actual_keyword_parameters = []
    actual_required_parameter_count = 0
    method.parameters.each do |category, name|
      if category==:req
        actual_required_parameter_count += 1
      elsif category==:key
        actual_keyword_parameters.push(name)
      elsif category==:opt
        actual_optional_parameters.push(name)
      end
    end

    remaining_keyword_parameters = target_keyword_parameters.dup
    remaining_keyword_parameters -= actual_keyword_parameters

    assert_equal([], actual_optional_parameters, "#{method}\noptional parameter(s) detected #{actual_optional_parameters}. use keyword parameters instead.\nhttps://github.com/rubocop/ruby-style-guide#keyword-arguments-vs-optional-arguments")
    assert_equal(target_required_parameter_count, actual_required_parameter_count, "#{method}\nexpected required parameter count: #{target_required_parameter_count}, actual required parameter count: #{actual_required_parameter_count}")
    assert_equal( [], remaining_keyword_parameters, "#{method}\nexpected keyword parameters: #{target_keyword_parameters}, actual keyword parameters: #{actual_keyword_parameters}\n\nremaining expected keyword parameters after removing all found keyword parameters: \n")
  end

end
