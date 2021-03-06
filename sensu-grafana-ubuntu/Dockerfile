#
# INSTALL SENSU AND GRAFANA (and associated dependencies)
#

FROM ubuntu:14.04

EXPOSE 3000 8080

# Copy service_start.sh - which is own custom 
COPY service_start.sh /root/service_start.sh
RUN chmod +x /root/service_start.sh

# Update apt repository
# Install wget
RUN apt-get update && apt-get install -y wget && apt-get install -y build-essential && apt-get install -y curl && apt-get install -y apt-transport-https
#RUN apt-get install -y wget

# Install the GPG public key
RUN wget -q http://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -

# Create an APT configuration file at /etc/apt/sources.list.d/sensu.list
RUN echo "deb http://sensu.global.ssl.fastly.net/apt sensu main" | tee /etc/apt/sources.list.d/sensu.list && apt-get update && apt-get install -y sensu

# Update apt repository
#RUN apt-get update

# Install sensu
#RUN apt-get install -y sensu

# Copy client.json
COPY client.json /etc/sensu/conf.d/client.json

# Copy transport.json
COPY transport.json /etc/sensu/conf.d/transport.json

# Copy api.json
COPY api.json /etc/sensu/conf.d/api.json

# Install Redis
RUN apt-get -y install redis-server

# Copy redis.json
COPY redis.json /etc/sensu/conf.d/redis.json

# Install Erlang
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb && apt-get update && apt-get -y install erlang-nox
#RUN dpkg -i erlang-solutions_1.0_all.deb 
#RUN apt-get update 
#RUN apt-get -y install erlang-nox

# Install rabbitmq
RUN wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.0/rabbitmq-server_3.6.0-1_all.deb && dpkg -i rabbitmq-server_3.6.0-1_all.deb 
#RUN dpkg -i rabbitmq-server_3.6.0-1_all.deb 

# Copy rabbitmq.json
COPY rabbitmq.json /etc/sensu/conf.d/rabbitmq.json

# Start the services
RUN echo STARTING SERVICES at `date` >> /tmp/start_services.out 2>> /tmp/start_services.out

RUN service sensu-server start && service sensu-client start && service rabbitmq-server start && service redis-server start && service sensu-api start

#RUN service sensu-server start >> /tmp/start_services.out 2>> /tmp/start_services.out
#RUN service sensu-client start >> /tmp/start_services.out 2>> /tmp/start_services.out
#RUN service rabbitmq-server start >> /tmp/start_services.out 2>> /tmp/start_services.out
#RUN service redis-server start >> /tmp/start_services.out 2>> /tmp/start_services.out
#RUN service sensu-api start >> /tmp/start_services.out 2>> /tmp/start_services.out

# Add a vhost to rabbitmq
# Add user for sensu in Rabbitmq
#RUN service rabbitmq-server start >> /tmp/start_services.out 2>> /tmp/start_services.out
#RUN rabbitmqctl add_user sensu secret
#RUN rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

RUN service rabbitmq-server start && rabbitmqctl add_vhost /sensu && rabbitmqctl add_user sensu secret  && rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

# Install Uchiwa dashboard
RUN apt-get install -y uchiwa

# Replace default uchiwa.json with custom one
#RUN  mv /etc/sensu/uchiwa.json /etc/sensu/uchiwa.json.orig
COPY uchiwa.json /etc/sensu/uchiwa.json

# Start uchiwa service
RUN  service uchiwa start

# Install sensu plugins
ENV PATH /opt/sensu/embedded/bin:$PATH
RUN sensu-install -p cpu-checks && /opt/sensu/embedded/bin/sensu-install -p disk-checks && /opt/sensu/embedded/bin/sensu-install -p memory-checks && /opt/sensu/embedded/bin/sensu-install -p nginx && /opt/sensu/embedded/bin/sensu-install -p process-checks && /opt/sensu/embedded/bin/sensu-install -p load-checks && /opt/sensu/embedded/bin/sensu-install -p vmstats && /opt/sensu/embedded/bin/sensu-install -p mailer

#RUN cd /opt/sensu/embedded/bin && ./sensu-install -p cpu-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p cpu-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p disk-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p memory-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p nginx  
#RUN /opt/sensu/embedded/bin/sensu-install -p process-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p load-checks  
#RUN /opt/sensu/embedded/bin/sensu-install -p vmstats  
#RUN /opt/sensu/embedded/bin/sensu-install -p mailer

# Copy jsons for monitoring parameters
COPY check_cpu_linux.json /etc/sensu/conf.d/check_cpu_linux.json
COPY check_memory_linux.json /etc/sensu/conf.d/check_memory_linux.json
COPY check_disk_usage_linux.json /etc/sensu/conf.d/check_disk_usage_linux.json

# Install postfilx
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postfix && cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf && /etc/init.d/postfix reload
#RUN cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf
#RUN /etc/init.d/postfix reload

COPY handler_mail.json /etc/sensu/handler_mail.json
COPY mailer.json /etc/sensu/mailer.json

# Restart sensu server TBD - This has to happen- failing with service dead pid exists
#RUN service sensu-server restart 
#RUN service sensu-server status && service sensu-server start 

# Set up auto start
RUN update-rc.d sensu-server defaults && update-rc.d sensu-client defaults && update-rc.d sensu-api defaults && update-rc.d uchiwa defaults
#RUN update-rc.d sensu-client defaults  
#RUN update-rc.d sensu-api defaults  
#RUN update-rc.d uchiwa defaults

# 0.2

# Install Graphite
RUN apt-get install -y graphite-carbon && echo "CARBON_CACHE_ENABLED=true" > /etc/default/graphite-carbon && service carbon-cache start

# Install web-ui
RUN apt-get install -y graphite-web apache2 libapache2-mod-wsgi && chown _graphite /var/lib/graphite && sudo -u _graphite graphite-manage syncdb --noinput && rm -f /etc/apache2/sites-enabled/000-default.conf && cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-enabled/graphite.conf && service apache2 restart

#-- good up to here

# Install Grafana
# configure the grafana repo
# new - from official doc (i have included the new one also from the old one)
COPY grafana_stable.list /etc/apt/sources.list.d/grafana_stable.list
# old - from tutorial doc
#RUN echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" | tee /etc/apt/sources.list.d/grafana.list  

# old - from tutorial
#RUN curl -k -O https://packagecloud.io/gpg.key && apt-key add gpg.key 
RUN curl -k https://packagecloud.io/gpg.key | sudo apt-key add -
# new - from frafana official doc
RUN curl -k -L https://packagecloud.io/grafana/stable/gpgkey | sudo apt-key add -

RUN apt-get install -y gnutls-bin
RUN update-ca-certificates -v
RUN apt-get update 
RUN apt-get install -y --allow-unauthenticated grafana

# Install git and clone sensu-metrics-relay
RUN apt-get install -y git && git clone git://github.com/opower/sensu-metrics-relay.git && cp -R sensu-metrics-relay/lib/sensu/extensions/* /etc/sensu/extensions/.
#cd sensu-metrics-relay  
#cp -R lib/sensu/extensions/* /etc/sensu/extensions

COPY relay.json /etc/sensu/conf.d/relay.json
COPY metrics-vmstat.json /etc/sensu/conf.d/metrics-vmstat.json

#--------
#CMD ["tail -f /dev/null"]
CMD ["/root/service_start.sh; tail -f /dev/null"]
