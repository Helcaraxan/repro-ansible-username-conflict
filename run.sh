#!/usr/bin/env bash

set -u -e -o pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

if [[ -z ${PROJECT_ID:-} ]]; then
    echo "Please set the GCE project ID to use via PROJECT_ID."
    exit 1
fi
ZONE="${ZONE:-europe-west1-b}"
echo "Creating target GCE instance in project '${PROJECT_ID}' in zone '${ZONE}'."
PACKER_USER="${PACKER_USER:-packer}"
echo "Packer will create and connect via a default non-root '${PACKER_USER}' user on the instance."
TARGET_USER="${TARGET_USER:-$(whoami)}"
echo "Ansible create a non-default '${TARGET_USER}' user."

packer build \
    -timestamp-ui \
    -var "project_id=${PROJECT_ID}" \
    -var "zone=${ZONE}" \
    -var "packer_user=${PACKER_USER}" \
    -var "target_user=${TARGET_USER}" \
    ./packer.json
