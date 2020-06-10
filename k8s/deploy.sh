#!/usr/bin/env bash

set -e -o pipefail

TF_OUTPUT=$(cd ../terraform && terraform output -json)
CLUSTER_NAME="$(echo ${TF_OUTPUT} | jq -r .kubernetes_cluster_name.value)"
STATE="s3://$(echo ${TF_OUTPUT} | jq -r .kops_s3_bucket.value)"
SSH_PUBLIC_KEY="/home/msilva/Desktop/Manitha/git/bayes-assignment/k8s/msilva.pub"

#kops create -f cluster.yaml
#kops update cluster --state ${STATE} --name ${CLUSTER_NAME} --yes
#kops toolbox template --name ${CLUSTER_NAME} --values <( echo ${TF_OUTPUT}) --template cluster-template.yaml --format-yaml > cluster.yaml
#kops create secret --name ${CLUSTER_NAME} --state ${STATE} sshpublickey admin -i ${SSH_PUBLIC_KEY}

#kops replace -f cluster.yaml --state ${STATE} --name ${CLUSTER_NAME} --force

#kops update cluster --target terraform --state ${STATE} --name ${CLUSTER_NAME} --out .

#kops update cluster --state ${STATE} --name ${CLUSTER_NAME}
#kops update cluster --state ${STATE} --name ${CLUSTER_NAME} --yes