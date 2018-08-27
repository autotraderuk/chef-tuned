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

describe file(libdir + 'myprofile') do
  it { should be_directory }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should be_mode 644 }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should be_owned_by 'root' }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should be_grouped_into 'root' }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should contain('[vm]').after(/^/) }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should contain('transparent_hugepage=never').after(/^/) }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should contain('transparent_hugepage.defrag=never').after(/^/) }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should contain('[main]').after(/^/) }
end

describe file(libdir + 'myprofile/tuned.conf') do
  it { should contain('include=latency-performance').after(/^/) }
end

describe command('tuned-adm active') do
  its('stdout') { should match (/myprofile/) }
end
