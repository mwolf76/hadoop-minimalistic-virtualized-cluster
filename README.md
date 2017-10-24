# Hadoop Minimalistic Virtualized Cluster

## Motivation

Having a quick and effective way to setup a virtualized cluster for development.

## Highlights

* 4 Nodes (1 master + 3 slaves).
* Based on Debian 9.2 (Stretch), 64 bit contrib image.
* Minimalistic install, OpenJDK 8 headless JRE.
* Shell-based provisioning.

## Requirements

* [Virtual Box](http://virtualbox.org)
* [Vagrant](http://vagrantup.com/)

## Deployment

* Clone this repository.
* Download the Hadoop 2.x distribution tarball from [here](https://hadoop.apache.org/releases.html) and put it under resources/dist.
* Adjust the version number in the Vagrantfile to match the Hadoop distribution version number.

Bring the cluster up.

    $ vagrant up

That's it!