# Sinatra helpers
class  Sinatra::Base
  def modal(message)
    @message = message
    @message = flash[:message] = haml :message, :layout => false
  end
end


# Haml helpers
class Sinatra::Base
  def cycle(first_value, *values)
    if (values.last.instance_of? Hash)
      params = values.pop
      name = params[:name]
    else
      name = "default"
    end
    
    values.unshift(first_value)

    cycle = get_cycle(name)
    unless cycle && cycle.values == values
      cycle = set_cycle(name, Cycle.new(*values))
    end
    
    cycle.to_s
  end

  def current_cycle(name = "default")
    cycle = get_cycle(name)
    cycle.current_value if cycle
  end

  def reset_cycle(name = "default")
    cycle = get_cycle(name)
    cycle.reset if cycle
  end

  class Cycle
    attr_reader :values

    def initialize(first_value, *values)
      @values = values.unshift(first_value)
      reset
    end

    def reset
      @index = 0
    end

    def current_value
      @values[previous_index].to_s
    end

    def to_s
      value = @values[@index].to_s
      @index = next_index
      return value
    end

    private

    def next_index
      step_index(1)
    end

    def previous_index
      step_index(-1)
    end

    def step_index(n)
      (@index + n) % @values.size
    end
   end

  private
  def get_cycle(name)
    @_cycles = Hash.new unless defined?(@_cycles)
    return @_cycles[name]
  end

  def set_cycle(name, cycle_object)
    @_cycles = Hash.new unless defined?(@_cycles)
    @_cycles[name] = cycle_object
  end
end
