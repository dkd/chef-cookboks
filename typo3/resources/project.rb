#
# Cookbook Name:: typo3
# Resource:: project
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

actions :create, :disable, :remove

attribute :name, :kind_of => String, :name_attribute => true
attribute :server_aliases, :kind_of => Array, :default => []
attribute :path, :kind_of => String
attribute :flavor, :kind_of => String, :default => "TYPO3_4-5"
attribute :version, :kind_of => String
attribute :exists, :default => false
attribute :link_target_file, :kind_of => String
attribute :copy_source, :default => false
