actions :create, :enable, :disable, :default
default_action :create

# man 'tuned.conf'
# MAIN SECTION
#   The main section is called "[main]"
property :main, kind_of: Hash, default: {}.freeze
# PLUGINS
#   Every other section defines one plugin.
property :plugins, kind_of: Hash, default: {}.freeze
