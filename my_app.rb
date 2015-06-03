require 'yaml'

class MyApp
  def self.call(env)
    [200, 'text/plain', "<pre>\n#{env.to_yaml}</pre>"]
  end
end