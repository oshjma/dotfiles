Pry::Commands.create_command '<<' do
  description 'Require ruby libraries.'
  command_options keep_retval: true

  def process
    results = args.map { |arg| require arg }
    results.size <= 1 ? results[0] : results
  end
end

module Kernel
  module_function

  def copy(obj)
    IO.popen('pbcopy', 'w') { |io| io << obj }
    nil
  end

  def paste
    `pbpaste`
  end

  def json(str)
    require 'json'
    str = File.read(str) if File.file?(str)
    JSON.parse(str)
  end

  def yaml(str)
    require 'yaml'
    str = File.read(str) if File.file?(str)
    YAML.load(str)
  end
end
