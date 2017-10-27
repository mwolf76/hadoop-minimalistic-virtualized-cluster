#!/bin/bash
HADOOP_VERSION="$1"
echo "Installing Hadoop ${HADOOP_VERSION} ..."

# Install hadoop distribution
HADOOP_TARBALL="hadoop-${HADOOP_VERSION}.tar.gz"
tar xf "/vagrant/resources/dist/${HADOOP_TARBALL}"
ln -s "hadoop-${HADOOP_VERSION}" hadoop

# Generate key pair for cluster connectivity, all machines will
# share the same key.
if [ ! -f /vagrant/resources/keys/id_rsa.pub ]; then
  echo "Shared RSA SSH key not found, generating a new one ..."
  ssh-keygen -t rsa -N '' -f /vagrant/resources/keys/id_rsa
fi

# copy keys
echo "Installing shared RSA SSH key ..."
cp /vagrant/resources/keys/id_rsa     ~/.ssh
cp /vagrant/resources/keys/id_rsa.pub ~/.ssh
  
# append public key to authorized keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# FIXME: Not so sure this belongs here :-/
echo "Writing common hadoop configuration ..."

echo "-- yarn-site.xml"
cat > ~/hadoop/etc/hadoop/yarn-site.xml <<EOF
<?xml version="1.0"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property> 
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>master.public</value>
  </property>
</configuration>
EOF

echo "-- mapreduce-site.xml"
cat > ~/hadoop/etc/hadoop/mapred-site.xml <<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
  <property>
    <name>mapreduce.jobtracker.address</name>
    <value>master.public:54311</value>
  </property>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
EOF

# Fix user profile
cat >> ~/.bashrc <<EOF
export HADOOP_PREFIX=~/hadoop
export PATH=~/hadoop/bin:~/hadoop/sbin:$PATH
EOF

cat >> ~/.bash_aliases <<EOF
# jps program is distributed only in jdk package, this will do for us ...
alias jps="ps -aux | grep java | grep -v grep | awk '{print \\\$2, \\\$NF}'"
EOF
