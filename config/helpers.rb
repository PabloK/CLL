# encoding: utf-8
# Sinatra helpers
class  Sinatra::Base
  # Calling this function in the controller will make
  # a message modal appear the next time the layout is rendered
  def modal(message)
    @message = message
    @message =  haml :message, :layout => false
    flash[:message] = @message
  end

  # This function is a helper that should be called to verify that
  # the user is logedin.
  def lookup_user
    if session[:user]
      @user = User.get(session[:user])
      if @user == nil or not @user.valid?(session[:lookup])
        session.delete(:user)
        session.delete(:lookup)
        halt 404
      end
    end
  end

  # This helper is called to login the user
  def login(user)
      if user.new_lookup!
        session[:user]=user.id
        session[:lookup]=user.lookup
        return
      end
      
      redirect '/login'
  end
end

# Haml helpers
class Sinatra::Base
  
  # These functions are ment to simplify the usage of the Cycle class  
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

  # This class is used to cycle between values during haml render
  # It can for instance be used to create tables with alternating classes like .odd, .even
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
