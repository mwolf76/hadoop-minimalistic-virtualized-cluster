#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# required by Hadoop NFS gateweay
apt-get install -y nfs-common

# NFS static name resolution
cat > /etc/nfs.map <<-EOF
	# Mapping for clients accessing the NFS gateway
	uid 1001 1000 # remote -> local UID
	EOF

# Adding nobody group
groupadd nobody
