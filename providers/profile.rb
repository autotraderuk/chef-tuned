# is whyrun supported
def whyrun_supported?
  true
end

action :create do
  # set tuned config path. Different for EL6/7
  libdir = (node['platform_version'].to_i < 7) ? '/etc/tune-profiles/' : '/usr/lib/tuned/'

  # defines local variables based on profile name
  profile = {
    :name => new_resource.name,
    :libdir => libdir + new_resource.name
  }

  # initialise empty attribute hash in case no attributes where specified
  # default [main] entry
  node.default['tuned'] ||= {}
  node.default['tuned']['profile'] ||= {}
  node.default['tuned']['profile'][profile[:name]] ||= {}
  node.default['tuned']['profile'][profile[:name]]['main'] ||= {}

  # create tuned profile directory
  directory profile[:libdir] do
    # recursive true
  end

  # create tuned profile file
  # pass in the profile name and attribute hash
  # for this profile
  template "#{profile[:libdir]}/tuned.conf" do
    source 'tuned_profile_skel.erb'
    owner 'root'
    group 'root'
    mode 00644
    cookbook 'tuned'
    variables :profiles => {
      'name' => profile[:name],
      'values' => node['tuned']['profile'][profile[:name]].to_hash
    }
  end
  new_resource.updated_by_last_action(true)
end

action :enable do
  profile = {
    :name => new_resource.name
  }

  # enables profile passed in by resource call
  execute "tuned #{profile[:name]} enable" do
    command "tuned-adm profile #{profile[:name]}"
  end
  new_resource.updated_by_last_action(true)
end

action :disable do
  profile = {
    :name => new_resource.name
  }

  # disables profile passed in by resource call
  execute "tuned #{profile[:name]} disable" do
    command 'tuned-adm off'
  end
  new_resource.updated_by_last_action(true)
end

action :default do
  profile = {
    :name => new_resource.name
  }

  # parses the recommended profile and enables it
  execute "tuned #{profile[:name]} default" do
    command 'tuned-adm recommend|xargs -r tuned-adm profile'
  end
  new_resource.updated_by_last_action(true)
end
