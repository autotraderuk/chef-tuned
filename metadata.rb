name 'tuned'
maintainer 'Dave Meekin'
maintainer_email 'davemeekin.github@gmail.com'
source_url 'https://github.com/autotraderuk/chef-tuned' if respond_to?(:source_url)
issues_url 'https://github.com/autotraderuk/chef-tuned/issues' if respond_to?(:source_url)
license 'Apache v2.0'
supports 'RHEL', '>= 6.6'
supports 'CentOS', '>= 6.6'
description 'Chef tuned cookbook handles tuned profile creation and actvation'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'

# dependancies here
