module ReConfigus
  class BuilderProxy

    def initialize(&block)
      @block = block
      @hash = {}
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
