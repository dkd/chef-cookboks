#
# Cookbook Name:: typo3
# Recipe:: default
#
# Copyright 2011, dkd Internet Service GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Load all required TYPO3 sources
# @deprecated Use deploy script for that

gem_package "mysql" do
  action :install
end

node['typo3']['versions'].each do |package|
  typo3_temp_path = "#{Chef::Config[:file_cache_path]}/typo3"
  Chef::Log.info "Download TYPO3 version #{package} to #{typo3_temp_path}"

  unless ::File.directory?("#{node['typo3']['share']['dir']}/typo3_src-#{package}")
    directory typo3_temp_path do
      owner node['typo3']['webroot']['owner']
      group node['typo3']['webroot']['group']
      mode "0770"
      recursive true
      action :create
    end

    remote_file "#{typo3_temp_path}/typo3_src-#{package}.tar.gz" do
      owner node['typo3']['webroot']['owner']
      group node['typo3']['webroot']['group']
      mode "0644"
      backup false
      source "#{node['typo3']['mirror']}typo3_src-#{package}.tar.gz"
      not_if do
        ::File.exists?("#{typo3_temp_path}/typo3_src-#{package}.tar.gz")
      end
    end

    execute "Unpack TYPO3 sources" do
      Chef::Log.info "Unpack TYPO3 sources to  #{typo3_temp_path}/typo3_src-#{package}.tar.gz"
      command "tar -zxf #{typo3_temp_path}/typo3_src-#{package}.tar.gz -C #{typo3_temp_path}"
      not_if do
        ::File.directory?("#{typo3_temp_path}/typo3_src-#{package}")
      end
    end

    execute "Copy TYPO3 sources to shared folder" do
      command "cp -r #{typo3_temp_path}/typo3_src-#{package} #{node['typo3']['share']['dir']}"
    end
  end
end
