#!/bin/bash
echo "Writing node-specific configuration for master ..."

echo "-- hdfs-site.xml"
cat > ~/hadoop/etc/hadoop/hdfs-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
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
    <name>dfs.replication</name>
    <value>3</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:///home/vagrant/hadoop/var/hdfs/namenode</value>
  </property>
</configuration>
EOF

echo "Creating name node directory ..."
mkdir -p ~/hadoop/var/hdfs/namenode

echo "-- masters"
cat > ~/hadoop/etc/hadoop/masters <<EOF
master.public
EOF

echo "-- slaves"
cat > ~/hadoop/etc/hadoop/slaves <<EOF
slave1.public
slave2.public
slave3.public
EOF

echo "Formatting name name ..."
~/hadoop/bin/hdfs namenode -format


