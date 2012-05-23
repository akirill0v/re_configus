require 're_configus/builder_proxy'
module ReConfigus
  class Builder

    def initialize(environment, &block)
      @current_env = environment
      @envs = {}
      @block = block
      @current = nil
      @clean_envs = []
    end

    def build
      instance_eval(&@block)
      @clean_envs.each do |k|
        @envs[k] = @envs[k].send(:build)
      end
      @envs.each do |k,v|
        @envs[k] = v.send(:build, @envs[v._parent_env_name].to_hash || {}) unless @clean_envs.include?(k)
      end
      p @envs
      self
    end

    def [](key)
      @current[key]
    end

    def to_hash
      @current.to_hash
    end

    def env(name, options = {}, &block)
      if block_given?
        @clean_envs << name if options[:parent].nil?
        @envs[name] = BuilderProxy.prepare(options[:parent], &block)
      else
        @envs[name]
      end
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
