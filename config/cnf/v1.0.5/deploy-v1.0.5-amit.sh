#! /bin/bash

set -ex
NS="f5-cnf"
CHART_DIR="/root/f5/charts/cnf/v1.0.5/cnfinstall/"
DIR="/root/f5/config/cnf/v1.0.5/"
for i in `kubectl get crd | awk '{print $1}' | grep -i f5net.com`; do kubectl delete crd $i; done
kubectl delete ns ${NS}
kubectl create ns ${NS}
kubectl config set-context --current --namespace ${NS}

helm install crds-n6lan ${CHART_DIR}f5-cnf-crds-n6lan-0.161.0-0.1.2.tgz
