module Nebula
  module Dsl
    class Main
      def self.evaluate(spec)
        builder = new
        builder.instance_eval(spec)
        builder.to_definition
      end

      def cloud(name, &block)
        @cloud = CloudBlock.evaluate(name, &block)
      end

      def to_definition
        @cloud
      end
    end

    class Base
      def self.evaluate(&block)
        builder = new
        builder.instance_eval(&block)
        builder.to_definition
      end

      def to_definition
        @target
      end
    end

    class NamedBase < Base
      def self.evaluate(name, &block)
        builder = new(name)
        builder.instance_eval(&block)
        builder.to_definition
      end
    end

    class CloudBlock < NamedBase
      def initialize(name)
        @target = Cloud.new(name)
      end

      def provider(name, &block)
        @target.provider = ProviderBlock.evaluate(name, &block)
      end

      def chef_solo(&block)
        @target.chef = ChefSoloBlock.evaluate(&block)
      end

      def compute_node(name, &block)
        @target.nodes << ComputeNodeBlock.evaluate(name, &block)
      end
    end

    class ProviderBlock < NamedBase
      def initialize(name)
        @target = Provider.new(name)
      end

      def method_missing(name, *args, &block)
        key = [@target.name.downcase, '_', name].join.to_sym
        @target.opts[ key ] = args.first
      end
    end

    class ChefSoloBlock < Base
      def initialize
        @target = ChefSolo.new
      end

      def repo(path)
        @target.repo_path = path
      end

      def bootstrap(template)
        @target.bootstrap_template = template
      end
    end

    class ComputeNodeBlock < NamedBase

      def initialize(name)
        @target = ComputeNode.new(name)
      end

      def flavor(val)
        @target.flavor = val
      end

      def image(val)
        @target.image = val
      end

      def role(name)
        @target.run_list << "role[#{name}]"
      end

      def recipe(name)
        @target.run_list << "recipe[#{name}]"
      end

      def override_attributes(atts)
        @target.override_attributes.merge!(atts)
      end
    end

    def self.evaluate(spec)
      Main.evaluate(spec)
    end
  end
end