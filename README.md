# Wraith
[![Build Status](https://travis-ci.org/coldfrontlabs/coldfrontlabs-wraith.svg?branch=master)](https://travis-ci.org/coldfrontlabs/coldfrontlabs-wraith)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with wraith](#setup)
    * [What wraith affects](#what-wraith-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install the [Wraith screenshot comparison tool](https://github.com/BBC-News/wraith) created by BBC News.

## Module Description

Installs Wraith on Ubuntu and newer versions of CentOS. Actually running Wraith commands is not supported. This only ensures that wraith is installed.

## Setup

### What wraith affects

* Installs Wraith
* Installs gcc and other tools required to compile gems

### Setup Requirements

* Requires PhantomJS (handled by 3fs/phantomjs)
* Requires Ruby 1.9.3 or later to be available on the system (sorry CentOS 6)

## Usage

One line required:

````puppet
include wraith
````

In your puppet module. Installs the latest version of Wraith.

## Reference

* https://github.com/BBC-News/wraith
* https://forge.puppetlabs.com/3fs/phantomjs

## Limitations

Supports:
 - Ubuntu 14.04+
 - CentOS 7+

## Development

We're only looking to build in more system support. Actually running wraith commands are considered out of scope for this module (unless you're really really convincing).

If someone wants to figure out how to get this module to work on CentOS 6, that would be greatly appreciated!