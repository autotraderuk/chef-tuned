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

describe command('tuned-adm active') do
  its('stdout') { should match (/latency-performance/) }
end
