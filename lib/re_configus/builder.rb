require 're_configus/builder_proxy'
module ReConfigus
  class Builder

    def initialize(environment, &block)
      @current_env = environment
      @envs = {}
      @block = block
      @current = nil
    end

    def build
      instance_eval(&@block)
      self
    end

    def [](key)
      @current[key]
    end

    def to_hash
      @current.to_hash
    end

    def env(name, options = {}, &block)
      @envs[name] = BuilderProxy.build(self, options, &block)
    end

    def method_missing(m, *args, &block)
      @current ||= @envs[@current_env]
      @current.send(m)
    end

    def self.build(env, &block)
      b = new(env, &block)
      b.build
    end

  end
end
