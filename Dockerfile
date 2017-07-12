FROM oberthur/docker-ubuntu-java:jdk8_8.121.13_V3

MAINTAINER Krzysztof Witkowski <k.witkowski@oberthur.com>

ENV JMETER_VERSION='3.1' \
JMETER_PLUGIN_EXTRAS_VERSION='1.4.0' \
JMETER_PLUGIN_STANDARD_VERSION='1.4.0' \
JMETER_CMD_VERSION='2.1'

RUN apt-get update \
    && apt-get -y install unzip \
    && curl -LO http://www-us.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
    && curl -LO https://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-$JMETER_PLUGIN_EXTRAS_VERSION.zip \
    && curl -LO https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-$JMETER_PLUGIN_STANDARD_VERSION.zip \
    && tar -zxvf apache-jmeter-$JMETER_VERSION.tgz \
    && mv apache-jmeter-$JMETER_VERSION apache-jmeter \
    && unzip -u JMeterPlugins-Extras-$JMETER_PLUGIN_EXTRAS_VERSION.zip -d /apache-jmeter \
    && unzip -u JMeterPlugins-Standard-$JMETER_PLUGIN_STANDARD_VERSION.zip -d /apache-jmeter \
    && curl -LO https://jmeter-plugins.org/files/packages/jpgc-cmd-$JMETER_CMD_VERSION.zip \
    && unzip -u jpgc-cmd-$JMETER_CMD_VERSION.zip -d /apache-jmeter \
    && rm apache-jmeter-$JMETER_VERSION.tgz \
    && rm jpgc-cmd-$JMETER_CMD_VERSION.zip \
    && rm JMeterPlugins-Extras-$JMETER_PLUGIN_EXTRAS_VERSION.zip \
    && rm JMeterPlugins-Standard-$JMETER_PLUGIN_STANDARD_VERSION.zip \
    && apt-get purge unzip \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

ENTRYPOINT ["/apache-jmeter/bin/jmeter", "-n", "-t"]
