#
# Cookbook Name:: tuned
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'tuned' do
  action :install
end

service 'tuned' do
  action [:enable, :start]
end
