#!/bin/bash

set -xe

#######################################
# Download Source Code
#######################################
git clone --quiet -b ${BRANCH#origin/} https://${REPO}.git ${WORKPATH}
cd ${WORKPATH}
go get ./...

#######################################
# Compile
#######################################
make all
make pack
mv open-falcon-v*.tar.gz /package/

