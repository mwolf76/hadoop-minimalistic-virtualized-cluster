#!/bin/bash
echo "Starting HDFS ..."
~/hadoop/sbin/start-dfs.sh

echo "Starting NFS gateway ..."
~/hadoop/sbin/hadoop-daemon.sh --script hadoop/bin/hdfs start nfs3

