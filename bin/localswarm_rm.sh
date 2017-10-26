#!/bin/bash

# Specify the number of managers and workers for the swarm
MANAGER=3
WORKER=3

for i in $(seq 1 $MANAGER); do docker-machine stop m$i; done
for i in $(seq 1 $WORKER); do docker-machine stop w$i; done

for i in $(seq 1 $MANAGER); do docker-machine rm m$i -y; done
for i in $(seq 1 $WORKER); do docker-machine rm w$i -y; done
