FROM ubuntu:latest
MAINTAINER BilalArif "billal.ariif@gmail.com"
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get install -y build-essential apache2 libxml2-dev \
 && a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html \
 && a2dissite 000-default.conf \
 && touch /etc/apache2/sites-available/proxy.conf \
 && printf "<VirtualHost *:80>\n\
  ServerAdmin webmaster@localhost\n\
  DocumentRoot /var/www/\n\
  ErrorLog ${APACHE_LOG_DIR}/error.log\n\
  CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
  ProxyPreserveHost off\n\
  ProxyPass / http://www.example.com/\n\
  ProxyPassReverse / http://www.example.com/\n\
  ServerName example.com\n\
</VirtualHost>\n" > /etc/apache2/sites-available/proxy.conf \
 && a2ensite proxy.conf \
 && a2enmod ssl \
 &&  printf "<VirtualHost *:443>\n\
        ServerAdmin webmaster@localhost\n\
        #DocumentRoot /var/www/\n\
        ErrorLog ${APACHE_LOG_DIR}/error.log\n\
        CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
        SSLEngine On\n\
        SSLProxyEngine On\n\
        SSLCertificateFile /etc/apache2/ca.crt\n\
        SSLCertificateKeyFile /etc/apache2/ca.key\n\
        ProxyPreserveHost off\n\
        ProxyPass / https://www.example.com/\n\
        ProxyPassReverse / https://www.example.com/\n\
        ServerName example.com\n\
</VirtualHost>\n" > /etc/apache2/sites-available/proxy-ssl-host.conf \
 && a2ensite proxy-ssl-host.conf
COPY ~/ssl /etc/apache2/.
EXPOSE 80
EXPOSE 443
ENTRYPOINT service apache2 restart && bash
