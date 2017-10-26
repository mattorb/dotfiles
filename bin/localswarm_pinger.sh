#!/bin/bash

docker $(docker-machine config m1) service create --replicas 3 --name pinger alpine ping docker.com