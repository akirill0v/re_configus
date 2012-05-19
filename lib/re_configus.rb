require "re_configus/version"
require "re_configus/builder"


module ReConfigus
  # Your code goes here...
  def re_configus
    ReConfigus::Builder
  end

  def build(env, &block)
    re_configus.default_env = env
    re_configus.build(&block)
  end
end

class Object
  include ReConfigus
end
