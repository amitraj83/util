#! /bin/bash
NS="my-cnf"
CHART_DIR="${HOME}/my-repo/charts/cnf/v1.0.5/cnfinstall/"
DIR="${HOME}/my-repo/config/cnf/v1.0.5/"

kubectl delete ValidatingWebhookConfiguration f5validate-${NS}
for i in `kubectl get crd | awk '{print $1}' | grep -i f5net.com`; do kubectl delete crd $i; done
kubectl delete ns ${NS}

kubectl create ns ${NS}
kubectl config set-context --current --namespace ${NS}

helm install crds-n6lan ${CHART_DIR}f5-cnf-crds-n6lan-0.36.7.tgz

kubectl apply -f ${DIR}certs-secret.yaml -n ${NS}
kubectl apply -f ${DIR}keys-secret.yaml -n ${NS}
kubectl apply -f ${DIR}natpolicy.yaml -n ${NS}
kubectl apply -f ${DIR}net-attach.yaml -n ${NS}
kubectl apply -f ${DIR}securecontext.yaml -n ${NS}
kubectl apply -f ${DIR}vlan.yaml -n ${NS}
kubectl apply -f ${DIR}default-route.yaml -n ${NS}

helm install f5cnf ${CHART_DIR}tar/f5ingress-6.0.38.tgz --values ${DIR}values-v1.0.5.yaml --namespace ${NS}

echo "helm install f5cnf ${CHART_DIR}tar/f5ingress-6.0.38.tgz --values ${DIR}values-v1.0.5.yaml --namespace ${NS}"
echo "helm uninstall f5cnf --namespace ${NS}"
