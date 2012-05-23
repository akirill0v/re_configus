module ReConfigus
  class BuilderProxy

    def initialize(builder, options, &block)
      @block = block
      @hash = {}
      @builder = builder
      @options = options
    end

    def build
      instance_eval(&@block)
      self
    end

    def [](key = nil)
      @hash[key]
    end

    def to_hash
      @hash.each do |k,v|
        @hash[k] = v.kind_of?(ReConfigus::BuilderProxy) ? v.to_hash : v
      end
    end

    def self.build(builder, options, &block)
      b = new(builder, options, &block)
      b.build
    end

    def method_missing(m, *args, &block)
      if block_given?
        @hash[m] = self.class.build(@builder, @options, &block)
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
