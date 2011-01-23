cluster "myproject" do
  provider "Rackspace"

  chef_solo do
    repo "/etc/chef-repo"
    bootstrap "/etc/chef-repo/boostraps/ubuntu64-ree.erb"
  end

  compute_node("app1") do
    role "app"
  end

  compute_node("app2") do
    role "app"
  end

  compute_node("db1") do
    role "db-master"
  end

  compute_node("db2") do
    role "db-slave"

    override_attributes :mysql => {
      :master => "mysql.master.local"
    }
  end

  compute_node("lb1") do
    role "load-balancer"
  end

  compute_node("lb2") do
    role "load-balancer"
  end

  compute_node("job") do
    role "app"
    recipe "resque"
  end

  # cdn do
  # end
  # 
  # storage do
  # end
  # 
  # dns do
  # end

end

# foreach instance
#   create instance
#   bootstrap instance
#   generate config file, attributes file
#   rsync config file, attributes file
#   rsync cookbooks and roles files if chef-solo
#   run chef-solo/chef-client
