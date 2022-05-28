# frozen_string_literal: true

# lib/controller.rb

class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
  end

  def layout
    ERB.new(File.read(File.join(App.root, 'app', 'views', 'layout.html.erb')))
  end

  def template
    ERB.new(File.read(File.join(App.root, 'app', 'views', name.to_s, "#{action}.html.erb")))
  end

  def call
    send(action)
    self.status = 200
    self.headers = { 'Content-Type' => 'text/html' }
    @content = template.result(binding)
    self.content = [layout.result(binding)]
    self
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ['Not found']
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ['Internal Server Error']
    self
  end
end
