#
# Cookbook Name:: typo3
# Recipe:: tools
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
# Load useful and required tools needed for TYPO3 to run
# This is just a plain list of tools.
# You may use cookbooks for that.
# Tested on ubuntu 10.04 only

include_recipe "graphicsmagick"

case node[:platform]
when "centos","redhat","fedora","suse"
  # Not supported at the moment
when "debian","ubuntu"
#  ak-31.05.12
# Remove libgs8 : Ubuntu 12.04 has   libgs9
# Remove xpdf-common: Ubuntu 12.04 has no packet xpdf-common
# Remove xpdf-utils:  Ubuntu 12.04 error: xpdf-utils is a virtual package provided by 2 packages, you must explicitly select one to install
  %w{
  catdoc
  ghostscript
  libphp-adodb
  exiftags
  }.each do |pkg|
    package pkg do
      action :install
    end
  end

end
