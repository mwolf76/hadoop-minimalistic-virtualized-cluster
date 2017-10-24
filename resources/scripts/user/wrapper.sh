#!/bin/bash
SCRIPT="$1"
VERSION="$2"

# echo "launching script: ${SCRIPT}, version: ${VERSION} ..."
su vagrant -c "source /vagrant/resources/scripts/user/${SCRIPT} ${VERSION}"

