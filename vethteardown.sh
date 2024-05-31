set -ex

containers=$(docker ps --filter ancestor=kindest/node:v1.28.9 --format "{{.ID}}")

for container in $containers; do
    # Check if ens5 exists and delete it
    if docker exec -it $container ip link show ens5 > /dev/null 2>&1; then
        docker exec -it $container ip link set ens5 down
        docker exec -it $container ip link set ens6 down
        docker exec -it $container ip link del ens5
    fi
done

