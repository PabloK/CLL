# encoding: utf-8

# Filename: helpers.rb
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# This file adds helper functions to the Sinatra::Base class.
# These functions are globaly available in the controllers
# The file is split in two parts helpers for the controlers called Sinatra helpers
# and helpers for haml rendering called Haml helpers

# Opening Sinatra::Base to add helper functions
class  Sinatra::Base
  
  ###
  # Sinatra Helpers
  ###
  
  # When a controler calls this function a message modal will appear.
  def modal(message)
    @message = message
    @message =  haml :message, :layout => false
    flash[:message] = @message
  end

  # Verifies the lookup key of a user
  def lookup_user
    if session[:user]
      @user = User.get(session[:user])
      if @user == nil or not @user.lookup_valid?(session[:lookup])
        session.delete(:user)
        session.delete(:lookup)
        modal({:heading => "Felaktig Session" ,:body => "Din session har blivit korrupt och du loggas nu ut."})
        redirect '/login'
      end
      return
    end
    redirect '/login'
  end

  ### 
  # Haml helpers
  ###  

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

  # This class is used to cycle between values during the redering of html from haml
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
