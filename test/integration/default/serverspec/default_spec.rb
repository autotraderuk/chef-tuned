# path to common helper spec when running on test system
require 'spec_helper'

describe service('tuned') do
  it { should be_enabled }
end

describe service('tuned') do
  it { should be_running }
end

describe package('tuned') do
  it { should be_installed }
end

describe file(libdir + 'default') do
  it { should be_directory }
end

describe file(libdir + 'default/tuned.conf') do
  it { should be_mode 644 }
end

describe file(libdir + 'default/tuned.conf') do
  it { should be_owned_by 'root' }
end

describe file(libdir + 'default/tuned.conf') do
  it { should be_grouped_into 'root' }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[cpu]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('governor=performance').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('energy_perf_bias=performance').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('min_perf_pct=100').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[disk]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('readahead=4096').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[vm]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('transparent_hugepage=never').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('transparent_hugepage.defrag=never').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[sysctl]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('kernel.sched_min_granularity_ns=10000000').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('kernel.sched_wakeup_granularity_ns=15000000').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('vm.dirty_background_ratio=10').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('vm.dirty_ratio=30').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('vm.swappiness=30').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[sysfs]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('sys/kernel/mm/transparent_hugepage/enabled=never').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('sys/kernel/mm/transparent_hugepage/defrag=never').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('[main]').after(/^/) }
end

describe file(libdir + 'default/tuned.conf') do
  it { should contain('include=latency-performance').after(/^/) }
end
