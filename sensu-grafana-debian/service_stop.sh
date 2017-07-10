echo >> /tmp/service_stop.out 2>> /tmp/service_stop.out
date >> /tmp/service_stop.out 2>> /tmp/service_stop.out
echo >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service sensu-server stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service sensu-client stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service rabbitmq-server stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service redis-server stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service sensu-api stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service uchiwa stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service carbon-cache stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service apache2 stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out
service grafana-server stop >> /tmp/service_stop.out 2>> /tmp/service_stop.out

