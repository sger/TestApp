#!/bin/bash

releaseBranch=$(git rev-parse --abbrev-ref HEAD)

IFS='/'
read -a strarr <<< "$releaseBranch"

if [ -n "${strarr[1]}" ]; then
    
    version=${strarr[1]}
    versionLabel=v$version

    developBranch=develop
    mainBranch=main

    git checkout $mainBranch
    git pull
    git merge --no-ff -m $versionLabel "release/${version}"
    git push
 
    git tag $versionLabel
    git push origin $versionLabel
 
    git checkout $developBranch
    git pull
    git merge --no-ff -m $versionLabel "release/${version}"
    git push
else
    echo "release branch variable is empty "
fi

