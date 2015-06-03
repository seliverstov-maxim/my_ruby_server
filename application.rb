require 'yaml'
require 'base_application.rb'

class Application < BaseApplication
  def call(env)
    response "<html><body><h1>Hello World</h1><pre>\n#{env.to_yaml}</pre></body></html>"
  end
end