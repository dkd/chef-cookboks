# Create main folder
# Create symlinks from web_app/htdocs/typo3_src to /share/typo3/version
# Copy TYPO3 dummy, dkd_standard or introduction package
# default: COPY NOTHING, because the files are deployed via cap deploy or shared folders
#
# Cookbook Name:: typo3
# Provider:: project
#
# Copyright 2010, dkd Internet Service GmbH
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

def initialize(*args)
  super
  @action = :create
end

action :create do
  project = new_resource.name
  Chef::Log.info "Creating project #{project} in #{new_resource.path}"

=begin
  typo3_shared_path = node[:typo3][:share][:dir]
  # Make sure that the required TYPO3 version is available
  # @see #13472
  typo3_package "#{new_resource.version}" do
    action :add
  end

  #unless ::File.directory?("#{new_resource.path}")
    # Create webroot directory
    directory "#{new_resource.path}/current" do
      owner "www-data"
      group "www-data"
      mode "0770"
      recursive true
      action :create
      not_if do 
        FileTest.symlink?("#{new_resource.path}/current")
      end
    end

    # Connecting to TYPO3 sources
    if new_resource.copy_source
      Chef::Log.info "Copy sources from share to destination"
      # /var/www/project/
      #  |- typo3_src -> ../typo3_src-4.2.1
      #  \- typo3_src-4.2.1/
      unless ::File.directory?("#{new_resource.path}/typo3_src-#{new_resource.name}")
        Chef::Log.info "TYPO3 sources not found - starting download"
        typo3_package "#{new_resource.version}" do
          action :add
        end
      end

      execute "copy sources" do
        Chef::Log.info "Copy sources to #{new_resource.path}"
        command "cp -r #{typo3_shared_path}typo3_src-#{new_resource.version} #{new_resource.path}"
      end
    else 
      Chef::Log.info "Link two times to shared sources"
      Chef::Log.info "There should always be a 'project' source which get's linked to shared folder"
      # /var/www/project/
      #  |- typo3_src -> ../typo3_src-4.2.1
      #  \- typo3_src-4.2.1 -> /usr/share/typo3_src-4.2.1
      link "#{new_resource.path}/typo3_src-#{new_resource.version}" do
        to "#{typo3_shared_path}/typo3_src-#{new_resource.version}"
        action :create
      end
    end

    link "#{new_resource.path}/typo3_src" do
      to "#{new_resource.path}/typo3_src-#{new_resource.version}"
      action :create
    end
=end
    unless node['mysql']['external']
      # Convert project name to database
      database_name = "typo3_#{project.gsub(/[.-]/, '_')}"
      # externalize conection info in a ruby hash
      mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

      # Create database
      mysql_database database_name do
        connection mysql_connection_info
        action :create
      end
    end

    # Create webroot directory
    directory new_resource.path do
      owner node['typo3']['webroot']['owner']
      group node['typo3']['webroot']['group']
      mode "0770"
      recursive true
      action :create
      not_if do
        FileTest.symlink?(new_resource.path)
      end
    end

    # Create vhost config and reload webserver
    Chef::Log.info "Calling web_app for project #{project} with webroot #{new_resource.path}"
    webroot_path = new_resource.path
    server_aliases = new_resource.server_aliases
    web_app project do
      cookbook "typo3"
      template "web_app.conf.erb"
      docroot "#{webroot_path}/current"
      server_name project
      server_aliases server_aliases
    end
    #end
    new_resource.updated_by_last_action(true)
end

action :disable do
  Chef::Log.info "Disable project #{new_resource.name} in #{new_resource.path}"
  apache_site "#{new_resource.name}.conf" do
    enable false
  end
end

action :remove do
  project = new_resource.name
  database_name = "typo3_#{project.gsub(/[.-]/, '_')}"

  Chef::Log.info "Removing project #{new_resource.name} in #{new_resource.path}"
  apache_site "#{new_resource.name}.conf" do
    enable false
  end

  directory new_resource.path do
    action :delete
    recursive true
  end
  Chef::Log.info "Delete database #{database_name}"
  mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

  # Create database
  mysql_database database_name do
    connection mysql_connection_info
    action :drop
  end
end
