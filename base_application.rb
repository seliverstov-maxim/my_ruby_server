class BaseApplication
  def call(env)
    raise "Need to define the call method"
  end

  def response(html, options={})
    [options.fetch(:response_code, 200), options.fetch(:content_type, 'text/html'), html]
  end
end