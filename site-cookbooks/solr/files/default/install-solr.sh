#!/bin/bash

TOMCAT_VER=6.0.33
SOLR_VER=3.4.0
EXT_SOLR_VER=2.0
EXT_SOLR_PLUGIN_VER=1.2.0

SVNBRANCH_PATH="branches/solr_$EXT_SOLR_VER.x"

Chef::Log.info "Checking requirements."

include_recipe "java"
include_recipe "wget"
include_recipe "zip"

directory "/opt/solr-tomcat" do
	recursive true
end


cd /opt/solr-tomcat/

Chef::Log.info "Using the mirror at Oregon State University Open Source Lab - OSUOSL."
Chef::Log.info "Downloading Apache Tomcat $TOMCAT_VER"

TOMCAT_MAINVERSION=`echo "$TOMCAT_VER" | cut -d'.' -f1`
wget --progress=bar:force http://apache.osuosl.org/tomcat/tomcat-$TOMCAT_MAINVERSION/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.zip 2>&1 | progressfilt

Chef::Log.info "Downloading Apache Solr $SOLR_VER"
wget --progress=bar:force http://apache.osuosl.org/lucene/solr/$SOLR_VER/apache-solr-$SOLR_VER.zip 2>&1 | progressfilt

Chef::Log.info "Unpacking Apache Tomcat."
unzip -q apache-tomcat-$TOMCAT_VER.zip

Chef::Log.info "Unpacking Apache Solr."
unzip -q apache-solr-$SOLR_VER.zip

mv apache-tomcat-$TOMCAT_VER tomcat

cp apache-solr-$SOLR_VER/dist/apache-solr-$SOLR_VER.war tomcat/webapps/solr.war
cp -r apache-solr-$SOLR_VER/example/solr .

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Downloading TYPO3 Solr configuration files."
cd solr

# create / download english core configuration
mkdir -p typo3cores/conf/english
cd typo3cores/conf/english

# test if release branch exists, if so we'll download from there
wget --no-check-certificate -q -O /dev/null https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH
BRANCH_TEST_RETURN=$?

# download english configuration in /opt/solr-tomcat/solr/typo3cores/conf/english/
if [ $BRANCH_TEST_RETURN -eq "0" ]
then
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/english/protwords.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/english/schema.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/english/stopwords.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/english/synonyms.txt 2>&1 | progressfilt
else
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/english/protwords.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/english/schema.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/english/stopwords.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/english/synonyms.txt 2>&1 | progressfilt
fi

# download general configuration in /opt/solr-tomcat/solr/typo3cores/conf/
cd ..
if [ $BRANCH_TEST_RETURN -eq "0" ]
then
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/admin-extra.html 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/elevate.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/general_schema_fields.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/general_schema_types.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/mapping-ISOLatin1Accent.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/typo3cores/conf/solrconfig.xml 2>&1 | progressfilt
else
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/admin-extra.html 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/elevate.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/general_schema_fields.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/general_schema_types.xml 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/mapping-ISOLatin1Accent.txt 2>&1 | progressfilt
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/typo3cores/conf/solrconfig.xml 2>&1 | progressfilt
fi

# download core configuration file solr.xml in /opt/solr-tomcat/solr/
cd ../..
rm solr.xml
if [ $BRANCH_TEST_RETURN -eq "0" ]
then
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/solr/solr.xml 2>&1 | progressfilt
else
wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/solr/solr.xml 2>&1 | progressfilt
fi

# clean up
rm -rf bin
rm -rf conf
rm -rf data
rm README.txt

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Configuring Apache Tomcat."
cd /opt/solr-tomcat/tomcat/conf

rm server.xml

if [ $BRANCH_TEST_RETURN -eq "0" ]
then
	wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/tomcat/server.xml 2>&1 | progressfilt
else
	wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/tomcat/server.xml 2>&1 | progressfilt
fi

cd /opt/solr-tomcat/
mkdir -p tomcat/conf/Catalina/localhost
cd tomcat/conf/Catalina/localhost

# set property solr.home
if [ $BRANCH_TEST_RETURN -eq "0" ]
then
	wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/$SVNBRANCH_PATH/resources/tomcat/solr.xml 2>&1 | progressfilt
else
	wget --progress=bar:force --no-check-certificate https://svn.typo3.org/TYPO3v4/Extensions/solr/trunk/resources/tomcat/solr.xml 2>&1 | progressfilt
fi

# copy libs
cd /opt/solr-tomcat/
mkdir solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-analysis-extras-$SOLR_VER.jar solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-cell-$SOLR_VER.jar solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-clustering-$SOLR_VER.jar solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-dataimporthandler-$SOLR_VER.jar solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-dataimporthandler-extras-$SOLR_VER.jar solr/dist
cp apache-solr-$SOLR_VER/dist/apache-solr-uima-$SOLR_VER.jar solr/dist
cp -r apache-solr-$SOLR_VER/contrib solr/

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Downloading the Solr TYPO3 plugin for access control. Version: $EXT_SOLR_PLUGIN_VER"
mkdir solr/typo3lib
cd solr/typo3lib
wget --progress=bar:force http://www.typo3-solr.com/fileadmin/files/solr/solr-typo3-plugin-$EXT_SOLR_PLUGIN_VER.jar 2>&1 | progressfilt

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Setting permissions."
cd /opt/solr-tomcat/
chmod a+x tomcat/bin/*

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Cleaning up."
rm -rf apache-solr-$SOLR_VER.zip
rm -rf apache-solr-$SOLR_VER
rm -rf apache-tomcat-$TOMCAT_VER.zip

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

Chef::Log.info "Starting Tomcat."
./tomcat/bin/startup.sh

Chef::Log.info "Done."
Chef::Log.info "Now browse to http://localhost:8080/solr/"
