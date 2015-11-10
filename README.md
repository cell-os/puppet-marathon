# marathon

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with marathon](#setup)
    * [What marathon affects](#what-marathon-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with marathon](#beginning-with-marathon)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Marathon scheduler for Mesos

## Module Description

Deploys Marathon as a Docker container.
Uses docker host network.

## Setup

### What marathon affects

* Pulls the Marathon Docker image
* Pulls the cellos/systemd-docker image
* Creates a systemd unit file (`/etc/systemd/system/marathon.service`)

### Setup Requirements 

OS level

* Systemd enabled host
* Docker enabled host

Service level

* Requires a Mesos cluster
* Requires Zookeeper

## Usage

marathon::master: "zk://localhost:2181/mesos"
marathon::zk: "zk://localhost:2181/marathon"

## Reference

* systemd-docker - https://github.com/ibuildthecloud/systemd-docker

## Limitations

Tested on CentOS 7.x.
It should work on any systemd / docker compatible host

## Development

This project is part of Adobe HSTACK project group.

### Source:
* https://git.corp.adobe.com/metal-cell/puppet-marathon

### JIRA project
* https://jira.corp.adobe.com/browse/HSTACK
* Component: [**puppet-marathon**](https://jira.corp.adobe.com/browse/HSTACK/component/24914)

### Contributing Guide
Check [Contributors Guide](https://git.corp.adobe.com/pages/hstack/opendev/contributing_guide.html)

# cellos-marathon
