#!/bin/bash

#from: https://gist.github.com/subfuzion/87144f39749145ff440186bb20513f55


# Specify the number of managers and workers for the swarm
MANAGER=3
WORKER=3

# Create the Docker hosts
# There is no difference between nodes other than the naming convention we use to
# distinguish between managers and workers. In production, you might choose to use
# higher capacity instances (cpu+memory) for managers.
for i in $(seq 1 $MANAGER); do docker-machine create --driver virtualbox --virtualbox-memory "4096" m$i; done
for i in $(seq 1 $WORKER); do docker-machine create --driver virtualbox w$i; done

# Init the swarm
docker $(docker-machine config m1) swarm init --advertise-addr $(docker-machine ip m1):2377
TM=$(docker $(docker-machine config m1) swarm join-token manager)
TW=$(docker $(docker-machine config m1) swarm join-token worker)
TOKENMANAGER=$([[ $TM =~ .*(SWMTKN[a-z0-9-]*[^ ]?).* ]] && echo ${BASH_REMATCH[1]})
TOKENWORKER=$([[ $TW =~ .*(SWMTKN[a-z0-9-]*[^ ]?).* ]] && echo ${BASH_REMATCH[1]})

# Add additional manager(s)
if [ $MANAGER -gt 1 ]; then
  for i in $(seq 2 $MANAGER); do
    docker $(docker-machine config m$i) swarm join --token $TOKENMANAGER --advertise-addr $(docker-machine ip m$i):2377 $(docker-machine ip m1):2377
  done
fi

# Add workers
for i in $(seq 1 $WORKER); do
  docker $(docker-machine config w$i) swarm join --token $TOKENWORKER $(docker-machine ip m1):2377
done

# Display nodes
docker $(docker-machine config m1) node ls

echo List nodes
echo 'docker $(docker-machine config m1) node ls'

echo List the services
echo 'docker $(docker-machine config m1) service ls'

echo List the service tasks
echo 'docker $(docker-machine config m1) service ps pinger'