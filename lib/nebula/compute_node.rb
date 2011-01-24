module Nebula
  class ComputeNode
    attr_accessor :name, :flavor, :image, :run_list, :override_attributes

    def initialize(name)
      @name = name
      @run_list = []
      @override_attributes = {}
    end
  end
end