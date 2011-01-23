module Nebula
  module Dsl
    class Main
      def self.evaluate(spec)
        builder = new
        builder.instance_eval(spec)
        builder.to_definition
      end

      def cluster(name, &block)
        @cluster = Cluster.new(name, &block)
      end

      def to_definition
        @cluster
      end
    end

    class Cluster
      attr_reader :name, :nodes, :provider, :chef

      def initialize(name, &block)
        @name  = name
        @nodes = []
        instance_eval(&block)
      end

      def provider(name)
        @provider = name
      end

      def chef_solo(&block)
        @chef = ChefSolo.new(&block)
      end

      def compute_node(name, &block)
        @nodes << ComputeNode.new(name, &block)
      end
    end

    class ChefSolo
      attr_reader :repo_path, :bootstrap_template

      def initialize(&block)
        instance_eval(&block)
      end

      def repo(path)
        @repo_path = path
      end

      def bootstrap(template)
        @bootstrap_template = template
      end
    end

    class ComputeNode
      def initialize(name, &block)
        @name = name
        @run_list = []
        @override_attributes = {}
        instance_eval(&block)
      end

      def role(name)
        @run_list << "role[#{name}]"
      end

      def recipe(name)
        @run_list << "recipe[#{name}]"
      end

      def override_attributes(atts)
        @override_attributes.merge!(atts)
      end
    end

    def self.evaluate(spec)
      Main.evaluate(spec)
    end
  end
end