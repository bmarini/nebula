module Nebula
  class Provider
    attr_accessor :name, :opts
    def initialize(name)
      @name = name
      @opts = { :provider => @name }
    end

    def compute
      Fog::Compute.new(opts)
    end
  end
end