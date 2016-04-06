#!/bin/bash

set -e

export REMOTE=origin
export BRANCH=develop
export REPO=github.com/Cepave/open-falcon-backend
export WORKPATH=${GOPATH}/src/${REPO}
export COMPONENT=${1:-all}
export SUBMODULE_BRANCH=develop

function set_git_modules() {
  modulelist=$(git config -f .gitmodules --get-regexp submodule.modules/[[:alnum:]]+?.path | awk -F " " -F "." '{ print $1 "." $2 }')
  for module in ${modulelist}
  do
    git config -f .gitmodules ${module}.branch ${SUBMODULE_BRANCH}
  done
  git config -f .gitmodules submodule.scripts/mysql.branch ${SUBMODULE_BRANCH}
}

#######################################
# Download Source Code
#######################################
rm -fR ${GOPATH}/* ~/.trash-cache
mkdir -p ${WORKPATH}
git clone --quiet -b ${BRANCH} https://${REPO}.git ${WORKPATH}
cd ${WORKPATH}
set_git_modules
git submodule --quiet update --init --recursive --remote
git submodule | sed 's/^+//g' | awk -F " " '{ print $1 " " $2 }' > /package/submodules.txt
go get github.com/rancher/trash
${GOPATH}/bin/trash --keep
go get ./...

#######################################
# Compile
#######################################
make ${COMPONENT}
make pack
mv open-falcon-v*.tar.gz /package/

