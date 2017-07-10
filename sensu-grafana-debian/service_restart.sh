echo >> /tmp/service_restart.out 2>> /tmp/service_restart.out
date >> /tmp/service_restart.out 2>> /tmp/service_restart.out
echo >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service sensu-server restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service sensu-client restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service rabbitmq-server restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service redis-server restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service sensu-api restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service uchiwa restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service carbon-cache restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service apache2 restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out
service grafana-server restart >> /tmp/service_restart.out 2>> /tmp/service_restart.out

