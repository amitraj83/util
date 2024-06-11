#! /bin/bash

# modify config for running on F5XC:
ln -fs ~/my-repo/charts/cnf/v1.0.5/cnfinstall/tar/f5ingress-6.0.38-xc.tgz ~/my-repo/charts/cnf/v1.0.5/cnfinstall/tar/f5ingress-xc-6.0.38.tgz

sed -i "s|values-v1.0.5.yaml|values-xc-v1.0.5.yaml|"  ~/my-repo/config/cnf/v1.0.5/deploy-v1.0.5.sh 
sed -i "s|f5ingress-6.0.38.tgz|f5ingress-xc-6.0.38.tgz|"  ~/my-repo/config/cnf/v1.0.5/deploy-v1.0.5.sh
sed -i "s|my-cnf|f5-cnf|"  ~/my-repo/config/cnf/v1.0.5/deploy-v1.0.5.sh
sed -i "s|ens6|eth4|" ~/my-repo/config/cnf/v1.0.5/net-attach.yaml
sed -i "s|ens7|eth5|" ~/my-repo/config/cnf/v1.0.5/net-attach.yaml
sed -i "s|10.1.20.|10.1.210.|" ~/my-repo/config/cnf/v1.0.5/vlan.yaml
sed -i "s|10.1.10.|10.1.200.|" ~/my-repo/config/cnf/v1.0.5/vlan.yaml
#sed -i "s|10.1.20.41|10.1.210.6|" ~/my-repo/config/cnf/v1.0.5/default-route.yaml
sed -i "s|10.1.20.41|10.1.210.1|" ~/my-repo/config/cnf/v1.0.5/default-route.yaml
sed -i "s|10.1.20.128/29|10.1.210.128/29|" ~/my-repo/config/cnf/v1.0.5/natpolicy.yaml
sed -i 's|NAMESPACE|f5-cnf|' ~/my-repo/config/cnf/v1.0.5/prometheus.yaml 
sed -i 's|NAMESPACE|f5-cnf|' ~/my-repo/config/cnf/v1.0.5/grafana.yaml
