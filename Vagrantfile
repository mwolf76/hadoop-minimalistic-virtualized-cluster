# -*- mode: ruby -*-
# vi: set ft=ruby :

# see https://hadoop.apache.org/releases.html
$hadoop_version = "2.8.1"

$master_msg = <<MSG
------------------------------------------------------
Hadoop

URLS:
 - cluster metrics      - http://localhost:8088
 - History Server       - http://localhost:19888
 - HDFS/DataNode health - http://localhost:50070

NFS:

  $ mount -t nfs 192.168.10.10:/ hdfs

------------------------------------------------------
MSG

Vagrant.configure("2") do |config|

  # contrib has VirtualBox Guest additions already installed
  config.vm.box = "debian/contrib-stretch64"

  # silence generic box post-up message
  config.vm.post_up_message = ""

  # slaves
  (1..3).each do |i|
    config.vm.define "slave#{i}" do |node|
      node.vm.network "private_network", ip: "192.168.10.1#{i}"
      node.vm.hostname = "slave1.local"

      node.vm.provision :shell,
                        :path => "resources/scripts/host/common.sh",
                        :name => "Host setup (common)",
                        :args => $hadoop_version

      node.vm.provision :shell,
                        :path => "resources/scripts/host/slave.sh",
                        :name => "Host setup (slave)",
                        :args => $hadoop_version

      node.vm.provision :shell,
                        :path => "resources/scripts/user/wrapper.sh",
                        :name => "User setup (common)",
                        :args => ["common.sh", $hadoop_version]

      node.vm.provision :shell,
                        :path => "resources/scripts/user/wrapper.sh",
                        :name => "User setup (slave)",
                        :args => ["slave.sh", $hadoop_version]

      node.vm.provider "virtualnode" do |vb|
        # Customize the amount of memory on the VM:
        vb.memory = "512"
      end
    end
  end

  # Master
  config.vm.define "master", primary: true do |node|
    node.vm.network "forwarded_port", guest: 8088,  host: 8088
    node.vm.network "forwarded_port", guest: 19888, host: 19888
    node.vm.network "forwarded_port", guest: 50070, host: 50070

    node.vm.provider "virtualnode" do |vb|
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end
    
    node.vm.network "private_network", ip: "192.168.10.10"
    node.vm.hostname = "master.local"

    node.vm.provision :shell,
                      :path => "resources/scripts/host/common.sh",
                      :name => "Host setup (common)",
                      :args => $hadoop_version

    node.vm.provision :shell,
                      :path => "resources/scripts/host/master.sh",
                      :name => "Host setup (master)",
                      :args => $hadoop_version

    node.vm.provision :shell,
                      :path => "resources/scripts/user/wrapper.sh",
                      :name => "User setup (common)",
                      :args => ["common.sh", $hadoop_version]

    node.vm.provision :shell,
                      :path => "resources/scripts/user/wrapper.sh",
                      :name => "User setup (master)",
                      :args => ["master.sh", $hadoop_version]

    node.vm.provision :shell,
                      :path => "resources/scripts/user/wrapper.sh",
                      :name => "(as vagrant) master script",
                      :args => ["start-hdfs.sh", $hadoop_version],
                      :run  => "always"

    node.vm.post_up_message = $master_msg
  end
end
