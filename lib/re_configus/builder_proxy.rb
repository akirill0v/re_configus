module ReConfigus
  class BuilderProxy

    def initialize(&block)
      @block = block
      @hash = {}
    end

    def build
      instance_eval(&@block)
    end

    def self.build(&block)
      b = new(&block)
      b.build
    end

    def method_missing(m, *args, &block)
      if block_given?
        @hash[m] = self.class.build(&block)
        self
      else
        if args.any?
          @hash[m] = args.first
          self
        else
          @hash[m]
        end
      end
    end
  end

end
