# is whyrun supported
def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  tuned_requirements
  # set tuned config path. Different for EL6/7
  libdir = (node['platform_version'].to_i < 7) ? '/etc/tune-profiles/' : '/usr/lib/tuned/'

  # defines local variables based on profile name
  profile = Mash.new(
    name: new_resource.name,
    libdir: libdir + new_resource.name
  )

  # initialise empty attribute hash in case no attributes where specified
  # default [main] entry
  profile['values'] = node['tuned']['profile'][profile['name']] || { main: new_resource.main }.merge(new_resource.plugins)

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
    variables profiles: profile
  end
end

action :enable do
  tuned_requirements
  profile = {
    :name => new_resource.name
  }

  # enables profile passed in by resource call
  execute "tuned #{profile[:name]} enable" do
    command "/usr/sbin/tuned-adm profile #{profile[:name]}"
    not_if "/usr/sbin/tuned-adm active | grep -q 'Current active profile: #{profile[:name]}'"
  end
end

action :disable do
  tuned_requirements
  profile = {
    :name => new_resource.name
  }

  # disables profile passed in by resource call
  execute "tuned #{profile[:name]} disable" do
    command '/usr/sbin/tuned-adm off'
  end
end

action :default do
  tuned_requirements

  profile = {
    :name => new_resource.name
  }

  # parses the recommended profile and enables it
  execute "tuned #{profile[:name]} default" do
    command '/usr/sbin/tuned-adm recommend|xargs -r /usr/sbin/tuned-adm profile'
  end
end

private

def tuned_requirements
  package 'tuned' do
    action :install
  end

  service 'tuned' do
    action [:enable, :start]
  end
end
