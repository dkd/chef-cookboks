#
# Cookbook Name:: solr
# Recipe:: server
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

include_recipe "java"
include_recipe "zip"
include_recipe "solr::php52_patch"

package "wget"

unless File.directory?("/opt/solr-tomcat/")
  if node[:solr][:server][:install_multi]
    # Download Solr server according to dkd standard
    # @see http://forge.typo3.org/projects/extension-solr/wiki/Setup_on_*NIX
    remote_file "#{Chef::Config[:file_cache_path]}/install-multi-solr.sh" do
      source "#{node[:solr][:server][:install_multi_sh]}"
      mode "0744"
      action :create_if_missing
    end

    execute "#{Chef::Config[:file_cache_path]}/install-multi-solr.sh -s #{node[:solr][:server][:versions].join(",")}"
  else
    # Download Solr server according to dkd standard
    # @see http://forge.typo3.org/projects/extension-solr/wiki/Setup_on_*NIX
    remote_file "#{Chef::Config[:file_cache_path]}/install-solr.sh" do
      source "#{node[:solr][:server][:install_sh]}"
      mode "0744"
      action :create_if_missing
    end

    execute "#{Chef::Config[:file_cache_path]}/install-solr.sh"
  end
end
