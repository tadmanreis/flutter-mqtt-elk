ARG ELASTIC_VERSION

# https://www.docker.elastic.co/
FROM docker.elastic.co/logstash/logstash:${ELASTIC_VERSION}


# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json
#Teste de mqtt
COPY plugins .

RUN echo "-----Installing  logstash-input-paho-mqtt----"; \
logstash-plugin install logstash-input-paho-mqtt-0.1.5.gem; \ 
rm logstash-input-paho-mqtt-0.1.5.gem
#Fim teste mqtt