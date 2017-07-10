echo >> /tmp/service_start.out 2>> /tmp/service_start.out
date >> /tmp/service_start.out 2>> /tmp/service_start.out
echo >> /tmp/service_start.out 2>> /tmp/service_start.out
service sensu-server start >> /tmp/service_start.out 2>> /tmp/service_start.out
service sensu-client start >> /tmp/service_start.out 2>> /tmp/service_start.out
service rabbitmq-server start >> /tmp/service_start.out 2>> /tmp/service_start.out
service redis-server start >> /tmp/service_start.out 2>> /tmp/service_start.out
service sensu-api start >> /tmp/service_start.out 2>> /tmp/service_start.out
service uchiwa start >> /tmp/service_start.out 2>> /tmp/service_start.out
service carbon-cache start >> /tmp/service_start.out 2>> /tmp/service_start.out
service apache2 start >> /tmp/service_start.out 2>> /tmp/service_start.out
service grafana-server start >> /tmp/service_start.out 2>> /tmp/service_start.out

