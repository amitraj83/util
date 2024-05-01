# Verifying if docker network "kind" exists
if ! docker network inspect kind > /dev/null 2>&1; then
  echo "Docker network 'kind' doesn't exist. Creating the network..."
  docker network create kind
fi

# Export docker network "kind" adress
KIND_PREFIX=$(docker network inspect kind -f '{{ (index .IPAM.Config 0).Subnet }}')
export CLUSTER_IP=$(echo $KIND_PREFIX | awk -F"." '{print $1"."$2"."$3".102"}')
echo $CLUSTER_IP
yq -i '.cluster_virtual_ip = strenv(CLUSTER_IP)' /root/sylva-core/environment-values/kubeadm-capd/values.yaml
