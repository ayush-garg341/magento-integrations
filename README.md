### This readme contains steps to integrate magento (running on k8s) with kafka, elastic apm and newrelic apm.

- I am using webdevops/php-nginx:7.3 as a base image upon which magento is running.
- The underlying OS is Debian GNU/Linux
- It's important that when we install the above modules, we have to include their .so ( shared object files ) in php.ini
- The location of php.ini might be different for different os and underlying base image. ( find it using "find / -name *.ini " ) 

- In the base docker file add two steps to install kafka.
    - RUN apt update && apt install -y librdkafka-dev && pecl install rdkafka
    - RUN echo extension=rdkafka.so >> /usr/local/etc/php/conf.d/php.ini 
    - RUN echo extension=rdkafka.so >> /usr/local/etc/php/php.ini-production
    - RUN echo extension=rdkafka.so >> /usr/local/etc/php/php.ini-development
- In case if needed can provide an example, (open an issue or write down to me).

- Let's see how we can install newrelic apm.
    - In order to add newrelic make an account on it (free upto a limit)
    - When we create an account, a license key gets generated. This key is needed to integrate newrelic with k8s magento pods.
    - We have created a separate file of steps to install newrelic ( newrelic.sh ) and then we copy the this file to the entrypoint folder.
    - Add the below steps in your docker file.
        - ENV NR_INSTALL_SILENT 1
        - ENV NR_INSTALL_KEY <license_key>
        - COPY newrelic.sh /opt/docker/provision/entrypoint.d/newrelic.sh

- Let's see how to install elastic apm.
    - When I tried installing it, I was not able to run it with my current setup as it was giving **zend_mm_corrupted** issue when we have both elastic_apm.so and ioncube_loader_lin_7.3.so
    - Deleting either will make work other but we can not have both running.
        - https://github.com/elastic/apm-agent-php/issues/123
    - In order to run elastic apm, delete .so file of ioncubeloader
    - Add the below step in your docker file.
        - COPY apm.sh /opt/docker/provision/entrypoint.d/apm.sh
