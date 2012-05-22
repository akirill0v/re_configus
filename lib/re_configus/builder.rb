require 're_configus/builder_proxy'
module ReConfigus
  class Builder

    def initialize(environment, &block)
      @current_env = environment
      @envs = {}
      @block = block
    end

    def build
      instance_eval(&@block)
      self
    end

    def env(name, options = {}, &block)
      @envs[name] = BuilderProxy.build(&block)
    end

    def method_missing(m, *args, &block)
      @envs[@current_env].send(m)
    end

    def self.build(env, &block)
      b = new(env, &block)
      b.build
    end

  end
end
