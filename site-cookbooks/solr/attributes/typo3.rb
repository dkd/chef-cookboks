#
# Cookbook Name:: solr
# Attributes:: typo3
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

default[:solr][:typo3][:version]       = "1.4"
default[:solr][:typo3][:branch]        = "branches/solr_#{solr[:typo3][:version]}.x"
default[:solr][:typo3][:afp_version]   = "1.1.0"
default[:solr][:typo3][:forge_path]    = "https://svn.typo3.org/TYPO3v4/Extensions/solr/"
