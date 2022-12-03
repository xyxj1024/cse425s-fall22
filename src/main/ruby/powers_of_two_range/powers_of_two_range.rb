# Xingjian Xuanyuan
# Dennis Cosgrove

class PowersOfTwoRange
  
  def initialize(maximum, inclusive: false)
    @maximum = maximum
    @inclusive = inclusive
  end

  def each
    if @inclusive
      if block_given?
        if @maximum < 1
          yield []
        else
          tmp = 1
          while tmp <= @maximum do
            yield tmp
            tmp *= 2
          end
        end
      else
        to_enum(__method__)
      end
    else
      if block_given?
        if @maximum < 1
          yield []
        else
          tmp = 1
          while tmp < @maximum do
            yield tmp
            tmp *= 2
          end
        end
      else
        to_enum(__method__)
      end
    end
  end

  def each_with_index
    if @inclusive
      if block_given?
        if @maximum < 1
          yield []
        else
          tmp = 1
          pow = 0
          while tmp <= @maximum do
            yield tmp, pow
            tmp *= 2
            pow += 1
          end
        end
      else
        to_enum(__method__)
      end
    else
      if block_given?
        if @maximum < 1
          yield []
        else
          tmp = 1
          pow = 0
          while tmp < @maximum do
            yield tmp, pow
            tmp *= 2
            pow += 1
          end
        end
      else
        to_enum(__method__)
      end
    end  
  end

end