#!/bin/sh

wget https://download.newrelic.com/php_agent/release/newrelic-php5-10.9.0.324-linux.tar.gz
tar -xvzf newrelic-php5-10.9.0.324-linux.tar.gz
cd newrelic-php5-10.9.0.324-linux
./newrelic-install install
sed -i '/^newrelic.appname/d' /usr/local/etc/php/conf.d/newrelic.ini
echo newrelic.appname = "app_name_anything_you_want" >> /usr/local/etc/php/conf.d/newrelic.ini
cd ..
