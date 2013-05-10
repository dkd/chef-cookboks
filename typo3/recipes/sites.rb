#
# Cookbook Name:: typo3
# Recipe:: sites
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
# Setup database, vhost and cronjob for a TYPO3 site
# @deprecated Should be done with application data_bags
# TODO ct 2012-01-24 Use application cookbook

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
  search(:applications, "type:typo3").each do |app|
    if (app["action_mode"] && !app["action_mode"].empty?)
      action_mode = app["action_mode"]
    else
      action_mode = "create"
    end

    Chef::Log.debug("Setting project action mode to #{action_mode}")

    app["stages"].each do |key, stage|

      if (stage['deploy_to']['fqdn'] == node['fqdn'])
        Chef::Log.debug("Installing TYPO3 on node #{node["fqdn"]} with #{key} #{stage.to_json}")
        Chef::Log.debug("vHost URL #{stage["url"]}")
        Chef::Log.debug("TYPO3 version #{stage["version"]}")
        Chef::Log.debug("Path #{stage["deploy_to"]["path"]}")

        typo3_project stage["url"] do
          version stage["version"]
          path stage["deploy_to"]["path"]
          server_aliases stage["server_aliases"]
          action action_mode
        end

        # Add cronjobs
        cron_file_name = stage["url"].gsub('.', '_')
        if stage['crontab'] && stage['crontab'].count > 0
          template "/etc/cron.d/#{cron_file_name}" do
            source "typo3-crontab.erb"
            variables(
              :jobs => stage["crontab"]
            )
          end
        else
          # Deactivate old cronjobs eg. for orphaned projects
          execute "mv /etc/cron.d/#{cron_file_name} /etc/cron.d/#{cron_file_name}~" do
            only_if do File.exists?("/etc/cron.d/#{cron_file_name}") end
          end
        end
      end
    end
  end
end
