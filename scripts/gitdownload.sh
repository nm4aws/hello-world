#!/bin/bash

Expected input is (1) github repo url (2) destination directory to download code into. Expected number of parameters = 2
if [ $# -ne 2 ]; then
    echo $0: usage: gitdownload {GitHubRepo DestinationDirectory}. "#=" $# " *=" $*
    exit 1
fi
githubrepo=$1
destdir=$2

#checking latest version number on github
echo "checking remote version..."
remoteversion=$(git ls-remote $githubrepo | grep HEAD | awk '{ print $1}')
echo "remote version is : " $remoteversion

#create desitnation directory if not already existing
mkdir -p $destdir
versionfile=$destdir/"version.txt"
localrepodir=$destdir/"repo"

#flag to signify if download is required or not
needdownload=0

#compare version number of github with version number in version file
#if github has updated version then download from github and update version file content
echo "checking version file : " $versionfile
if [ -f $versionfile ]; then
    localversion=$(cat $versionfile)
    echo "local version is : " $localversion
    if [ "$remoteversion" == "$localversion" ]; then
        echo "latest version already available locally, no need to download from remote repo"
    else
        needdownload=1
        echo "updated version available on remote repo, need to download from remote repo"
    fi
else
    needdownload=1
    echo "version file doesn't exist, need to download from remote repo"
fi

if [ $needdownload -eq 1 ]; then
    #udpate version file and download from git
    echo "updating latest version number in version file..."
    echo $remoteversion > $versionfile
    echo "updated latest version"
    echo "downloading latest version from github..."
    rm -rf $localrepodir
    git clone $githubrepo $localrepodir
    echo "downloaded"
fi