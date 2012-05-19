module ReConfigus
  class Builder
    attr_accessor :default_env
    attr_reader :environments
    attr_reader :builder

    def initialize(default_env = nil)
      p "-----------"
      @default_env = default_env
      @environments = {}
    end

    def build(&block)
    end

    def env(name, options={}, &block)
      @env = name
    end

    def method_missing(name, *args, &block)
    end

  end
end
