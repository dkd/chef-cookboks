#
# Cookbook Name:: solr
# Recipe:: php52_patch
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

if platform?("ubuntu") && node[:lsb][:codename] == "lucid"
  package "python-software-properties"

  execute "apt-get update" do
    action :nothing
  end

  template "/etc/apt/preferences" do
    source "preferences.rb"
    mode 0755
    owner "root"
    group "root"
   end

  apt_repository node['solr']['php52_patch']['repo_name'] do
    uri node['solr']['php52_patch']['repo_uri']
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key node['solr']['php52_patch']['repo_key']
    action :add
  end

  Chef::Log.info "Installing PHP 5.2 Patch"

  package "php5" do
    action :upgrade
    options "-f"
  end
end
