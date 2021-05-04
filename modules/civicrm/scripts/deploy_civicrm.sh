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

sed -i '/memory_limit = 128M/c\memory_limit = 256M' /etc/httpd/conf/httpd.conf
sed -i '/max_execution_time = 30/c\max_execution_time = 240' /etc/httpd/conf/httpd.conf
sed -i '/max_input_time = 60/c\max_input_time = 120' /etc/httpd/conf/httpd.conf
sed -i '/post_max_size = 8M/c\post_max_size = 50M' /etc/httpd/conf/httpd.conf


systemctl restart httpd

echo "CiviCRM deployed !"
