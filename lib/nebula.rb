require 'fog'

module Nebula
  autoload :Dsl, 'nebula/dsl'
  autoload :ChefSolo, 'nebula/chef_solo'
  autoload :Cloud, 'nebula/cloud'
  autoload :ComputeNode, 'nebula/compute_node'
  autoload :Provider, 'nebula/provider'

  class Builder
    def self.build(cloud)
      builder = new(cloud)
      builder.build
    end

    def initialize(cloud)
      @cloud = cloud
    end

    # foreach node
    #   create node instance
    #   bootstrap instance
    #   generate config file, attributes file
    #   rsync config file, attributes file
    #   rsync cookbooks and roles files if chef-solo
    #   run chef-solo/chef-client

    def build
      nodes = @cloud.nodes.collect { |node| create_compute_node(node) }
      p nodes
    end

    def create_compute_node(node)
      puts "Building #{node.inspect}"
      server = compute.servers.create(
        :name      => node.name,
        :flavor_id => node.flavor,
        :image_id  => node.image
      )

      server.wait_for { ready? }
      server
    end

    def compute
      @compute ||= @cloud.provider.compute
    end
  end
end

