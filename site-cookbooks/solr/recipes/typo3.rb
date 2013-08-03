#
# Cookbook Name:: solr
# Recipe:: typo3
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

include_recipe "solr::server"

# TODO ct 2011-11-05 Implement recipe for creating Solr Cores for TYPO3 sites
# if solr-server
#   each databag do solr core if app.fqdn == node.fqdn
