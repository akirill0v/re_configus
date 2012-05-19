require "re_configus/version"
require "re_configus/builder"


module ReConfigus
  # Your code goes here...

  def self.build(env, &block)
    Builder.build(env, &block)
  end
end
