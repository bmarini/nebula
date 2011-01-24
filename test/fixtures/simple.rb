cloud "myproject" do
  # Use environment variables to pull credentials out of this config file
  provider "Rackspace" do
    api_key '123'
    username '456'
  end

  chef_solo do
    repo "/etc/chef-repo"
    bootstrap "/etc/chef-repo/boostraps/ubuntu64-ree.erb"
  end

  compute_node("app1") do
    flavor "small"
    image "ubuntu-10.04"
    role "app"
  end

  compute_node("app2") do
    flavor "small"
    image "ubuntu-10.04"
    role "app"
  end

  compute_node("db1") do
    flavor "small"
    image "ubuntu-10.04"
    role "db-master"
  end

  compute_node("db2") do
    flavor "small"
    image "ubuntu-10.04"
    role "db-slave"

    override_attributes :mysql => {
      :master => "mysql.master.local"
    }
  end

  compute_node("lb1") do
    flavor "small"
    image "ubuntu-10.04"
    role "load-balancer"
  end

  compute_node("lb2") do
    flavor "small"
    image "ubuntu-10.04"
    role "load-balancer"
  end

  compute_node("job") do
    flavor "small"
    image "ubuntu-10.04"
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

