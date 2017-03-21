#!/bin/bash

set -xe

#######################################
# Download Source Code
#######################################
git clone --quiet -b ${BRANCH#origin/} https://${REPO}.git ${WORKPATH}
cd ${WORKPATH}
go get github.com/rancher/trash

#######################################
# Compile
#######################################
make all
make pack
mv open-falcon-v*.tar.gz /package/

