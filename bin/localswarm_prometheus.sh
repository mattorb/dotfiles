#!/bin/bash
pushd .
tmpdir=$(mktemp -d)
cd $tmpdir
git clone https://github.com/mattorb/swarmprom.git
cd swarmprom

ADMIN_USER=admin                                                                                    
ADMIN_PASSWORD=admin
SLACK_URL=https://hooks.slack.com/services/TOKEN
SLACK_CHANNEL=devops-alerts
SLACK_USER=alertmanager
docker $(docker-machine config m1) stack deploy -c docker-compose.yml mon

popd

echo stack definition in $tmpdir / swarmprom

docker $(docker-machine config m1) stack ls
docker $(docker-machine config m1) stack services mon

echo 'Stack list:   docker $(docker-machine config m1) stack ls'
echo 'Services in stack list: docker $(docker-machine config m1) stack services mon'
echo 'To remove this stack:   docker $(docker-machine config m1) stack rm mon'

echo Prometheus on http://$(docker-machine ip m1):9090
echo Grafana on http://$(docker-machine ip m1):3000
echo AlertManager on http://$(docker-machine ip m1):9093
echo Unsee on http://$(docker-machine ip m1):9094