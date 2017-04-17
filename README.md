#Tuned Chef Cookbook

[![Join the chat at https://gitter.im/autotraderuk/chef-tuned](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/autotraderuk/chef-tuned?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/autotraderuk/chef-tuned.svg?branch=master)](https://travis-ci.org/autotraderuk/chef-tuned)
[![Code Climate](https://codeclimate.com/github/autotraderuk/chef-tuned/badges/gpa.svg)](https://codeclimate.com/github/autotraderuk/chef-tuned)
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/autotraderuk/chef-tuned?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

#Description

Installs tuned and enables/disables tuned profiles. For more information on tuned please see the [Red Hat documentation](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Power_Management_Guide/Tuned.html) on this daemon

#Usage

###Attribute overview

Define some attributes to be used by the 'tuned_profile' resource.
Attributes have 3 levels
````
default['tuned']['profile']['myprofile']
````
- used as the profile filename must match resource instance name

````
default['tuned']['profile']['myprofile']['cpu']
````
- creates a heading in the profile init file [cpu]

````
default['tuned']['profile']['myprofile']['cpu']['governor'] = 'performance'
````
- creates an key value entry in the profile file under the '[cpu]' heading

###Attribute example


````
default['tuned']['profile']['myprofile']['cpu']['governor'] = 'performance'
default['tuned']['profile']['myprofile']['cpu']['energy_perf_bias'] = 'performance'
default['tuned']['profile']['myprofile']['cpu']['min_perf_pct'] = '100'
default['tuned']['profile']['myprofile']['disk']['readahead'] = '4096'
default['tuned']['profile']['myprofile']['vm']['transparent_hugepage'] = 'never'
default['tuned']['profile']['myprofile']['vm']['transparent_hugepage.defrag'] = 'never'
default['tuned']['profile']['myprofile']['sysctl']['kernel.sched_wakeup_granularity_ns'] = '15000000'
default['tuned']['profile']['myprofile']['sysctl']['kernel.sched_min_granularity_ns'] = '10000000'
default['tuned']['profile']['myprofile']['sysctl']['vm.dirty_background_ratio'] = '10'
default['tuned']['profile']['myprofile']['sysctl']['vm.dirty_ratio'] = '30'
default['tuned']['profile']['myprofile']['main']['include'] = 'latency-performance'
default['tuned']['profile']['myprofile']['sysctl']['vm.swappiness'] = '30'
default['tuned']['profile']['myprofile']['sysfs']['/sys/kernel/mm/transparent_hugepage/enabled'] = 'never'
default['tuned']['profile']['myprofile']['sysfs']['/sys/kernel/mm/transparent_hugepage/defrag'] = 'never'
````
The above example attributes when combined with a resource call:

````
tuned_profile 'myprofile' do
 action [:create, :enable]
end
````

Will create a file

- /usr/lib/tuned/myprofile/tuned.conf

With the following contents:

```
# Dynamically generated default tuned profile file, applied by Chef!
[main]
include=latency-performance
[cpu]
governor=performance
energy_perf_bias=performance
min_perf_pct=100
[disk]
readahead=4096
[sysctl]
kernel.sched_wakeup_granularity_ns=15000000
kernel.sched_min_granularity_ns=10000000
vm.dirty_background_ratio=10
vm.dirty_ratio=30
vm.swappiness=30
[sysfs]
/sys/kernel/mm/transparent_hugepage/enabled=never
/sys/kernel/mm/transparent_hugepage/defrag=never
[vm]
transparent_hugepage=never
transparent_hugepage.defrag=never
```

Installs tuned if not already installed

###create and enable a profile
````
tuned_profile 'myprofile' do
 action [:create, :enable]
end
````

###enable a default system profile
See Red Hat Documentation for availale defaults
````
tuned_profile 'balanced' do
 action [:enable]
end
````

###disable a profile (reverts to default)
````
tuned_profile 'myprofile' do
  action [:disable]
end
````

###default to tuned recommended profile
````
tuned_profile 'myprofile' do
  action [:default]
end
````
###Library Provider overview
####Property:


Name | Description | Default
-----|-------------|--------
`main` | Define the _[main]_ profile definition section | {}
`plugins` | Define the _plugins_ profile definition | {}


####Property example:
```
tuned_profile 'lwrp_profile' do
  main (include: 'latency-performance')
  plugins(cpu: {
            governor: 'performance',
            energy_perf_bias: 'performance'
          })
  action [:create, :enable]
end
```

#Contributing
1. Fork it
2. Create your feature branch + tests + Readme (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request





# Requirements

## Platform:

* RHEL (>= 6.6)
* CentOS (>= 6.6)

## Cookbooks:

*No dependencies defined*

# Attributes

*No attributes defined*

# Recipes

* tuned::default

# Resources

* [tuned_profile](#tuned_profile)

## tuned_profile

### Actions

- create:  Default action.
- default:
- disable:
- enable:

# License and Maintainer

Maintainer:: Dave Meekin (<davemeekin.github@gmail.com>)

License:: Apache v2.0
