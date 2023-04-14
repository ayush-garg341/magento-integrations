#!/bin/sh

[ -d "apm-agent-php" ] && echo "Apm Agent Php exists" || git clone https://github.com/elastic/apm-agent-php.git

cd apm-agent-php
cd src/ext
apt-get update
apt-get install -y libcurl4-openssl-dev
phpize
CFLAGS="-std=gnu99" ./configure --enable-elastic_apm
make clean
make
echo extension=/app/apm-agent-php/src/ext/modules/elastic_apm.so >> /usr/local/etc/php/conf.d/php.ini
echo extension=/app/apm-agent-php/src/ext/modules/elastic_apm.so >> /usr/local/etc/php/php.ini-production
echo extension=/app/apm-agent-php/src/ext/modules/elastic_apm.so >> /usr/local/etc/php/php.ini-development

echo elastic_apm.enabled=true >> /usr/local/etc/php/conf.d/php.ini
echo elastic_apm.server_url=$apm_server_url >> /usr/local/etc/php/conf.d/php.ini
echo elastic_apm.service_name=$apm_service_name >> /usr/local/etc/php/conf.d/php.ini

echo elastic_apm.enabled=true >> /usr/local/etc/php/php.ini-production
echo elastic_apm.server_url=$apm_server_url >> /usr/local/etc/php/php.ini-production
echo elastic_apm.service_name=$apm_service_name >> /usr/local/etc/php/php.ini-production

echo elastic_apm.enabled=true >> /usr/local/etc/php/php.ini-development
echo elastic_apm.server_url=$apm_server_url >> /usr/local/etc/php/php.ini-development
echo elastic_apm.service_name=$apm_service_name >> /usr/local/etc/php/php.ini-development

echo elastic_apm.bootstrap_php_part_file=/app/apm-agent-php/src/bootstrap_php_part.php >> /usr/local/etc/php/conf.d/php.ini
echo elastic_apm.bootstrap_php_part_file=/app/apm-agent-php/src/bootstrap_php_part.php >> /usr/local/etc/php/php.ini-production
echo elastic_apm.bootstrap_php_part_file=/app/apm-agent-php/src/bootstrap_php_part.php >> /usr/local/etc/php/php.ini-development

cd ..
