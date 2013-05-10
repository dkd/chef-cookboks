
# DESCRIPTION:

Helps you setting up a TYPO3 project on a LAMP system, which is the typical use case.

This cookbook helps you manage TYPO3 sources, packages, databases and vHosts on your nodes.

The cookbook provides LWRPs that allow easy management of downloading TYPO3 packages to a Website-Documentroot.
Developers may prefer the source installations of TYPO3 which comes directly from the official git-repository.

The cookbook also handles the creation of MySQL-Databases and vHosts on Apache2.
Other Datases and Webservers are planned.

The cookbook can be used to install these sites:

* dummy site - for kickstarting brand new websites
* introduction package - an example site with loads of functions
* your custom website - In this case you have to provide all the files for the website.

# RESOURCES AND PROVIDERS

This cookbook provides LWRPs for managing TYPO3 projects:

## source

* Downloads TYPO3 sources
* Created links to provide TYPO3-sources in your website

## package


## project

* Creates database for TYPO3-Website
* Creates database user "typo3" with limited access rights
* Creates vhost and documentroot for web-app

# REQUIREMENTS:

## Platform

Tested on Ubuntu 10.04

## Recipes

* The apache2 cookbook. Support for other webservers are planned.
* The mysql cookbook. Support for other databases are planned.

The cookbook configures the database user "typo3"

# ATTRIBUTES:

# USAGE:

