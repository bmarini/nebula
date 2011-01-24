module Nebula
  class Cloud
    attr_accessor :name, :nodes, :provider, :chef

    def initialize(name)
      @name = name
      @nodes = []
    end
  end
end