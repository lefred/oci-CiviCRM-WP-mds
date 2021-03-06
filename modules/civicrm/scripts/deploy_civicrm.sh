#!/bin/bash
#set -x

if [[ $(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/') == "el8" ]]
then
  dnf -y install php-bcmath php-intl
else
  yum -y install php-bcmath php-intl
fi


cd /var/www/html/wp-content/plugins/
wget https://download.civicrm.org/latest/civicrm-STABLE-wordpress.zip
unzip civicrm-STABLE-wordpress.zip
rm civicrm-STABLE-wordpress.zip
chown -R apache civicrm

chcon -R --type httpd_sys_rw_content_t /var/www/html/wp-content/plugins/civicrm

/usr/sbin/setsebool httpd_can_network_connect 1

sed -i '/memory_limit = 128M/c\memory_limit = 256M' /etc/php.ini
sed -i '/max_execution_time = 30/c\max_execution_time = 240' /etc/php.ini
sed -i '/max_input_time = 60/c\max_input_time = 120' /etc/php.ini
sed -i '/post_max_size = 8M/c\post_max_size = 50M' /etc/php.ini


systemctl restart httpd

echo "CiviCRM deployed !"
