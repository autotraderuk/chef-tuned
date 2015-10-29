require 'serverspec'

set :backend, :exec

def libdir
  (os[:release].to_i < 7) ? '/etc/tune-profiles/' : '/usr/lib/tuned/'
end
