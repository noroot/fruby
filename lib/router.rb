# frozen_string_literal: true

# lib/router.rb
#

class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    path = env['REQUEST_PATH']
    if routes.key?(path)
      ctrl(routes[path]).call
    else
      Controller.new.not_found
    end
  rescue Exception => e
    puts e.message
    puts e.backtrace
    Controller.new.internal_error
  end

  private

  def ctrl(string)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get "#{ctrl_name.capitalize}Controller"
    klass.new(name: ctrl_name, action: action_name.to_sym)
  end
end
