module ReConfigus
  class BuilderProxy

    def initialize(parent_env_name = nil, &block)
      @parent_env_name = parent_env_name
      @block = block
      @hash = {}
    end

    def build(parent_hash = {})
      instance_eval(&@block)
      @hash = parent_hash.merge(@hash)
      self
    end

    def [](key = nil)
      @hash[key]
    end

    def _parent_env_name
      @parent_env_name
    end

    def to_hash
      @hash.each do |k,v|
        @hash[k] = v.kind_of?(ReConfigus::BuilderProxy) ? v.to_hash : v
      end
    end

    def self.prepare(parent, &block)
      new(parent, &block)
    end

    def self.build(&block)
      b = new(&block)
      b.build
    end

    def method_missing(m, *args, &block)
      if block_given?
        @hash[m] = self.class.build(&block)
      else
        if args.any?
          @hash[m] = args.first
        else
          @hash[m]
        end
      end
    end
  end

end
