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

------------------------------------------------------
MSG

Vagrant.configure("2") do |config|

  # contrib has VirtualBox Guest additions already installed
  config.vm.box = "debian/contrib-stretch64"

  # silence generic box post-up message
  config.vm.post_up_message = ""

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  # Multi-machine configuration
  config.vm.define :slave1 do |box|
    box.vm.network "private_network", ip: "192.168.10.11"
    box.vm.hostname = "slave1.local"

    box.vm.provision :shell,
                     :path => "resources/scripts/host.sh",
                     :name => "Host setup",
                     :args => $hadoop_version

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) common script",
                     :args => ["common.sh", $hadoop_version]

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) slave script",
                     :args => ["slave.sh", $hadoop_version]

  end

  config.vm.define :slave2 do |box|
    box.vm.network "private_network", ip: "192.168.10.12"
    box.vm.hostname = "slave2.local"

    box.vm.provision :shell,
                     :path => "resources/scripts/host.sh",
                     :name => "Host setup",
                     :args => $hadoop_version

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) common script",
                     :args => ["common.sh", $hadoop_version]

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) slave script",
                     :args => ["slave.sh", $hadoop_version]

  end

  config.vm.define :slave3 do |box|
    box.vm.network "private_network", ip: "192.168.10.13"
    box.vm.hostname = "slave3.local"

    box.vm.provision :shell,
                     :path => "resources/scripts/host.sh",
                     :name => "Host setup",
                     :args => $hadoop_version

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) common script",
                     :args => ["common.sh", $hadoop_version]

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) slave script",
                     :args => ["slave.sh", $hadoop_version]
  end

  config.vm.define :master, primary: true do |box|
    box.vm.network "forwarded_port", guest: 8088,  host: 8088
    box.vm.network "forwarded_port", guest: 19888, host: 19888
    box.vm.network "forwarded_port", guest: 50070, host: 50070

    box.vm.network "private_network", ip: "192.168.10.10"
    box.vm.hostname = "master.local"

    box.vm.provision :shell,
                     :path => "resources/scripts/host.sh",
                     :name => "Host setup",
                     :args => $hadoop_version

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) common script",
                     :args => ["common.sh", $hadoop_version]

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) master script",
                     :args => ["master.sh", $hadoop_version]

    box.vm.provision :shell,
                     :path => "resources/scripts/user/wrapper.sh",
                     :name => "(as vagrant) master script",
                     :args => ["start-hdfs.sh", $hadoop_version],
                     :run  => "always"

    box.vm.post_up_message = $master_msg
  end
end
