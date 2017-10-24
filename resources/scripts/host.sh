#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

HADOOP_TARBALL="hadoop-$1.tar.gz"
if [ ! -f /vagrant/resources/dist/${HADOOP_TARBALL} ]; then
  echo "Please download ${HADOOP_TARBALL} and put it under resources/dist."
  exit 1
fi
echo "Found ${HADOOP_TARBALL} in resources/dist. Proceeding ..."

echo "Synchronizing APT sources ..."
apt-get update

echo "Installing OpenJDK 8 JRE (headless) ..."
apt-get install -y openjdk-8-jre-headless

# Static cluster nodes name resolution
cat >> /etc/hosts <<-EOF
	## Cluster nodes
	192.168.10.10 master.public
	192.168.10.11 slave1.public
	192.168.10.12 slave2.public
	192.168.10.13 slave3.public
	EOF

# Disable strict host key checking
cat >> /etc/ssh/ssh_config <<-EOF
	BatchMode yes
	StrictHostKeyChecking no
	EOF

# Fix JAVA_HOME env var
cat >> /etc/environment <<-EOF
	export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
	EOF
