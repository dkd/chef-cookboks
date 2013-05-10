#
# Cookbook Name:: typo3
# Recipe:: default
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

# Supported TYPO3 versions
# @deprecated Use deploy script for downloading TYPO3 sources
default['typo3']['versions'] = []

# Set attributes for TYPO3 packages
# @deprecated Use deploy script for downloading & handling TYPO3 sources
default['typo3']['share']['dir'] = "/usr/share/typo3"
default['typo3']['dir'] = "/tmp/typo3/"
default['typo3']['mirror'] = "http://prdownloads.sourceforge.net/typo3/"

default['typo3']['webroot']['owner'] = "www-data"
default['typo3']['webroot']['group'] = "www-data"

# Set defaults for typo3 databases (eg. for dummy packages)
# @deprecated use encrypted databag per customer for these values
# @see #13417
default['typo3']['db']['database'] = "typo3"
default['typo3']['db']['host']     = "127.0.0.1"
default['typo3']['db']['user']     = "typo3"
default['typo3']['db']['prefix']   = "typo3_"
default['typo3']['db']['password'] = "typo3"
