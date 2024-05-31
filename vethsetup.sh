#! /bin/bash

set -ex




containers=$(docker ps --filter ancestor=kindest/node:v1.28.9 --format "{{.ID}}")


for container in $containers; do
    # Check if ens5 already exists
    if ! docker exec -it $container ip link show ens5 > /dev/null 2>&1; then
        docker exec -it $container ip link add ens5 type veth peer name ens6
    fi

    # Check if ens6 is up, then set up interfaces and add IPs
    if ! docker exec -it $container ip link show ens6 | grep 'state UP' > /dev/null 2>&1; then
        docker exec -it $container ip link set ens5 up
        docker exec -it $container ip link set ens6 up
        docker exec -it $container ip addr add 10.111.0.0/24 dev ens5
        docker exec -it $container ip addr add 10.222.0.0/24 dev ens6
        docker exec -it $container sysctl -w net.ipv4.ip_forward=1
    fi
done


