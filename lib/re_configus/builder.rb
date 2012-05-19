require 're_configus/builder_proxy'
module ReConfigus
  class Builder
    class << self
      attr_accessor :default_env, :envs

      def method_missing(method_sym, *arguments, &block)
        proxy_builder = self.envs[self.default_env]
      end

      def respond_to?(method_sym, include_private = false)
        super
      end
    end

    def self.build(&block)
      self.envs = {}
      instance_eval &block
    end

    def self.env(name, options={}, &block)
      self.envs[name] = BuilderProxy.new(options)
      self.envs[name].build(&block)
    end

  end
end
