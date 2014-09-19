# Puppet module: zip

This is a Puppet module for zip
It provides only package installation and management

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-zip

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install zip with default settings

        class { 'zip': }

* Install a specific version of zip package

        class { 'zip':
          version => '1.0.1',
        }

* Remove zip resources

        class { 'zip':
          absent => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'zip':
          noops => true
        }

* Automatically include a custom subclass

        class { 'zip':
          my_class => 'example42::my_zip',
        }


[![Build Status](https://travis-ci.org/example42/puppet-zip.png?branch=master)](https://travis-ci.org/example42/puppet-zip)
